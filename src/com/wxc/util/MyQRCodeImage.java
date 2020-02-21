package com.wxc.util;
  
import java.awt.image.BufferedImage;  
  
import jp.sourceforge.qrcode.data.QRCodeImage;  
/**
 * @ClassName:     MyQRCodeImage.java
 * @Description:   TODO(二维码图片实体类) 
 * @author         yangjie
 * @version        V1.0  
 * @Date           2016-5-17 上午8:54:03
 */
public class MyQRCodeImage implements QRCodeImage {  
  
    BufferedImage bufImg;  
      
    public MyQRCodeImage(BufferedImage bufImg) {  
        this.bufImg = bufImg;  
    }  
      
    @Override  
    public int getHeight() {  
        return bufImg.getHeight();  
    }  
  
    @Override  
    public int getPixel(int x, int y) {  
        return bufImg.getRGB(x, y);  
    }  
  
    @Override  
    public int getWidth() {  
        return bufImg.getWidth();  
    }  
  
}  