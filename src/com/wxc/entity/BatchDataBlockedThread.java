package com.wxc.entity;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.wxc.action.QueueController;
import com.wxc.httputil.ApiUtil;
import com.wxc.service.OriginService;
import com.wxc.util.YmConfiguration;
import com.wxc.util.ZXingCode;

import net.sf.json.JSONObject;


public class BatchDataBlockedThread extends Thread{
	
	private String secret;
	private String chaincode;
	private String path;
	private File logoFile;
	private OriginService originService;
	
	public BatchDataBlockedThread(String secret, String chaincode, String path, File logoFile,OriginService originService) {
		super();
		this.secret = secret;
		this.chaincode = chaincode;
		this.path = path;
		this.logoFile = logoFile;
		this.originService=originService;
	}

	@Override
	public void run() {
		
		if (!QueueController.mapList.isEmpty() && QueueController.mapList.containsKey(this.chaincode)) {
			List<Origin> list = QueueController.mapList.get(this.chaincode);
			while(QueueController.mapIsStart.get(this.chaincode)){
				System.out.println("线程开启--------------------------------------------");
				if (list!=null && list.size()>0) {
					for (Origin origin2 : list) {
						System.out.println(list.size()+"=========================================");
						OriginalData originalData = new OriginalData();
						originalData.setId(origin2.getId());
						originalData.setValue1(origin2.getArea());
						originalData.setValue2(origin2.getExamine());
						originalData.setValue3(origin2.getIdentifier());
						originalData.setValue4(origin2.getName());
						originalData.setValue5(origin2.getQuality());
						originalData.setValue6(origin2.getStoragetime());
						originalData.setHash(origin2.getHash());
						try {
							long fileName = System.currentTimeMillis();
							File QrCodeFile = new File(path+"/"+fileName+".png");
							ZXingCode.drawLogoQRCode(logoFile, QrCodeFile, YmConfiguration.server+"Traceable/qrcodeContent.do?id="+origin2.getId(), "");
							origin2.setQrcode("upload/"+fileName+".png");
							
							//调用写入hyperledger区块接口
							Map<String, Object> map = new HashMap<String, Object>();
							map.put("secret", secret);
							map.put("data", originalData);
							map.put("key", "CPSec"+originalData.getId());
							map.put("chaincodeID", chaincode);
							String data = ApiUtil.insertData(map);
							JSONObject json = JSONObject.fromObject(data);
							System.out.println("json==================================="+json.toString());
//							int blocknumber = json.getInt("number");
//							String blockHash = json.getString("current_hash");
//							origin2.setBlocknumber(blocknumber);
//							origin2.setBlockhash(blockHash);
							//保存成功
							origin2.setStatus(1);
							Date date = new Date();
							SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
							String saveTime = sdf.format(date);
							origin2.setSavetime(saveTime);
							this.originService.updateOrigin(origin2);
							if (!QueueController.mapIsStart.get(this.chaincode)) {
								break;
							}
						} catch (Exception e) {
							//保存失败
							origin2.setStatus(0);
							this.originService.updateOrigin(origin2);
							e.printStackTrace();
						}
					}
					list=null;
				}else{
					QueueController.mapIsStart.put(this.chaincode, false);
				}
			}
		}
	
		
	}
	
}