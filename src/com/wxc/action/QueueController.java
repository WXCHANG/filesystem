package com.wxc.action;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wxc.entity.BatchDataBlockedThread;
import com.wxc.entity.Channel;
import com.wxc.entity.ChannelUser;
import com.wxc.entity.Origin;
import com.wxc.service.ChannelUserService;
import com.wxc.service.OriginService;

@Controller
public class QueueController {
	//每个chaincode对应存放集合
	private Map<String, BatchDataBlockedThread> mapThread = new HashMap<String,BatchDataBlockedThread>();
	public static volatile Map<String, List<Origin>> mapList = new HashMap<String, List<Origin>>();
	public static volatile Map<String, Boolean> mapIsStart = new HashMap<String, Boolean>();
	public static ExecutorService cachedThreadPool = Executors.newCachedThreadPool();
	@Resource
	private OriginService originService;
	@Resource
	private ChannelUserService channelUserService;
	/**
	 * 开启批量处理
	 * @return
	 */
	@RequestMapping("/startProcessData.do")
	@ResponseBody
	public Map<String, Object> startProcessData(HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		try{
			ChannelUser channelUser = (ChannelUser) session.getAttribute("channelUser");
			Channel channel = channelUserService.queryChannelByIdentifier(channelUser.getChannelidentifier());
			mapIsStart.put(channel.getChaincode(), true);
			/*if (!mapThread.isEmpty() && mapThread.containsKey(channel.getChaincode())) {
				BatchDataBlockedThread batchDataBlockedThread = mapThread.get(channel.getChaincode());
				State state = batchDataBlockedThread.getState();
				if(state.WAITING != null){
					List<Origin> list = QueueController.mapList.get(channel.getChaincode());
					mapList.put(channel.getChaincode(), list);
					map.put("code", 2);
					batchDataBlockedThread.notify();
					return map;
				}else if(state.NEW!=null){
					List<Origin> list = QueueController.mapList.get(channel.getChaincode());
					mapList.put(channel.getChaincode(), list);
					batchDataBlockedThread.start();
					map.put("code", 3);
					return map;
				}
			}*/
			String path = session.getServletContext()
					.getRealPath("upload");
			File logoFile = new File(session.getServletContext().getRealPath("images")+"/logo.png");
			List<Origin> list = originService.getNoSave(channelUser.getChannelidentifier());
			mapList.put(channel.getChaincode(), list);
			BatchDataBlockedThread batchDataBlockedThread = new BatchDataBlockedThread(channelUser.getSecretkey(),
					channel.getChaincode(),path,logoFile,originService);
			mapThread.put(channel.getChaincode(),batchDataBlockedThread);
			cachedThreadPool.execute(batchDataBlockedThread);
//			batchDataBlockedThread.start();
			map.put("code", 1);
		}catch (Exception e){
			e.printStackTrace();
			map.put("code", 0);
		}
		return map;
	}
	/**
	 * 关闭批量处理
	 * @return
	 */
	@RequestMapping("/stopProcessData.do")
	@ResponseBody
	public Map<String, Object> stopProcessData(HttpSession session){
		Map<String, Object> result = new HashMap<String, Object>();
		ChannelUser channelUser = (ChannelUser) session.getAttribute("channelUser");
		Channel channel = channelUserService.queryChannelByIdentifier(channelUser.getChannelidentifier());
		if (!mapThread.isEmpty() && mapThread.containsKey(channel.getChaincode())) {
//			BatchDataBlockedThread batchDataBlockedThread = mapThread.get(channel.getChaincode());
//			System.out.println(batchDataBlockedThread+"===================================");
//			try {
//				Thread.sleep(1000);
//				batchDataBlockedThread.interrupt();
				mapIsStart.put(channel.getChaincode(), false);
				System.out.println("线程停止--------------------------");
				result.put("code", 1);
//			} catch (InterruptedException e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//				result.put("code", 0);
//			}
		}
		return result;
	}
	
	public Map<String, Object> stateTest(){
		Map<String, Object> result = new HashMap<String, Object>();
		
		return result;
	}
	
/*	//开启底层数据存入区块线程
		public void startSaveBlock(final String secret,final String chaincode,
				final String path,final File logoFile){
			new Thread(new Runnable() {
				@Override
				public void run() {
					while(true){
						if (mapQueue.containsKey(chaincode)&& !mapQueue.get(chaincode).isEmpty() && mapQueue.get(chaincode).size()>0) {
							LinkedBlockingQueue<OriginalData> queue = mapQueue.get(chaincode);
							OriginalData originalData=null;
							Origin origin =null;
							try {
								originalData=queue.take();
								origin = originService.queryById(originalData.getId());
								long fileName = System.currentTimeMillis();
								File QrCodeFile = new File(path+"/"+fileName+".png");
								ZXingCode.drawLogoQRCode(logoFile, QrCodeFile, YmConfiguration.server+"Traceable/qrcodeContent.do?id="+origin.getId(), "");
								origin.setQrcode("upload/"+fileName+".png");
								//保存成功
								origin.setStatus(1);
								Date date = new Date();
								SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
								String saveTime = sdf.format(date);
								origin.setSavetime(saveTime);
								//调用写入hyperledger区块接口
								Map<String, Object> map = new HashMap<String, Object>();
								map.put("secret", secret);
								map.put("data", originalData);
								map.put("key", "CPSec"+originalData.getId());
								map.put("chaincodeID", chaincode);
								String data = ApiUtil.insertData(map);
								JSONObject json = JSONObject.fromObject(data);
								System.out.println("json==================================="+json.toString());
								int blocknumber = json.getInt("number");
								String blockHash = json.getString("current_hash");
								origin.setBlocknumber(blocknumber);
								origin.setBlockhash(blockHash);
								originService.updateOrigin(origin);
							} catch (Exception e) {
								try {
									//保存失败
									queue.put(originalData);
									origin.setStatus(0);
									originService.updateOrigin(origin);
									e.printStackTrace();
								} catch (InterruptedException e1) {
									// TODO Auto-generated catch block
									e1.printStackTrace();
								}
							}
						}
					}
				}
				
			}).start();
		}*/
}
