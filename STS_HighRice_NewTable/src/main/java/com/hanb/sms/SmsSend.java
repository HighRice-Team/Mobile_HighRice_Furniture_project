package com.hanb.sms;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;


//import kr.co.youiwe.webservice.CEncrypt;
import kr.co.youiwe.webservice.ServiceSMSSoapProxy;

public class SmsSend {
	public static void send(String phone, int n)
	{
		BufferedReader in;
	    in = new BufferedReader(new InputStreamReader(System.in));

		String smsID= "rola";	
		String hashValue="hanbit0828";
	
		ServiceSMSSoapProxy sendsms = new ServiceSMSSoapProxy();
		try{
			
			String senderPhone= "01036517605";
			String receivePhone= phone;
			String smsContent= "휴대폰 인증번호 ["+n+"]을 입력해주세요";
			String test1 = (smsID+hashValue+receivePhone);
			CEncrypt encrypt = new CEncrypt("MD5",test1);
			java.lang.String send = sendsms.sendSMS(smsID,encrypt.getEncryptData(), senderPhone, receivePhone, smsContent);
		
		}catch(Exception e){
		System.out.println("Exception in main:" +e);
		}
	}
}

class CEncrypt
{
    MessageDigest md;
    String strSRCData = "";
    String strENCData = "";

    public CEncrypt(){}
    public CEncrypt(String EncMthd, String strData)
    {
        this.encrypt(EncMthd, strData);
    }

    public void encrypt(String EncMthd, String strData)
   {
       try
      {
          MessageDigest md = MessageDigest.getInstance(EncMthd); // "MD5" or "SHA1"
         byte[] bytData = strData.getBytes();
         md.update(bytData);

         byte[] digest = md.digest();
         StringBuffer sb = new StringBuffer();
         for(int i =0;i<digest.length;i++)
         {
        	 strENCData = sb.append(Integer.toString((digest[i]&0xff) + 0x100, 16).substring(1)).toString();
         }
       }catch(NoSuchAlgorithmException e)
      {
         System.out.print(e);
      };
    
      strSRCData = strData;
    }

    public String getEncryptData(){return strENCData;}
    public String getSourceData(){return strSRCData;}

    public boolean equal(String strData)
    {
      if(strData == strENCData) return true;
      return false;
    }
}
