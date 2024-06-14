package com.dreamland.prj.utils;

import java.util.Base64;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;

public class AESUtils {
  private static final String ALGORITHM = "AES";
  private static final byte[] KEY = "mysecretkey12345".getBytes(); // 16바이트 키 (128비트)

  // 암호화
  public static String encrypt(String data) throws Exception {
      SecretKeySpec secretKey = new SecretKeySpec(KEY, ALGORITHM);
      Cipher cipher = Cipher.getInstance(ALGORITHM);
      cipher.init(Cipher.ENCRYPT_MODE, secretKey);
      byte[] encryptedData = cipher.doFinal(data.getBytes());
      return Base64.getEncoder().encodeToString(encryptedData);
  }

  //복호화
  public static String decrypt(String encryptedData) throws Exception {
      SecretKeySpec secretKey = new SecretKeySpec(KEY, ALGORITHM);
      Cipher cipher = Cipher.getInstance(ALGORITHM);
      cipher.init(Cipher.DECRYPT_MODE, secretKey);
      byte[] decodedData = Base64.getDecoder().decode(encryptedData);
      byte[] originalData = cipher.doFinal(decodedData);
      return new String(originalData);
  }
}
