package com.common.util;

import java.security.MessageDigest;

import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.spec.SecretKeySpec;

/**
 * @PackageName: com.common.util
 * @FileName : AesCrypto.java
 * @프로그램 설명 : 암호화
 */
public class AesCrypto {

    private static final String TRANSFORM = "AES/ECB/PKCS5Padding";
    private static final String STATIC_KEY = "_shop_crypto_ps_";  // must be 16bytes

    /**
     * <pre>
     * 1. MethodName : encrypt
     * 2. ClassName  : AesCrypto.java
     * 3. Comment    : 암호화
     * </pre>
     *
     * @param plainText
     * @return asHex
     * @throws Exception
     */
    public static String encrypt(String plainText) throws Exception {
        KeyGenerator kgen = KeyGenerator.getInstance("AES");
        kgen.init(128);

        byte[] raw = AesCrypto.STATIC_KEY.getBytes();
        SecretKeySpec skeySpec = new SecretKeySpec(raw, "AES");
        Cipher cipher = Cipher.getInstance(TRANSFORM);

        cipher.init(Cipher.ENCRYPT_MODE, skeySpec);
        byte[] encrypted = cipher.doFinal(plainText.getBytes());

        return asHex(encrypted);
    }

    /**
     * <pre>
     * 1. MethodName : decrypt
     * 2. ClassName  : AesCrypto.java
     * 3. Comment    : 복호화
     * </pre>
     *
     * @param plainText
     * @return originalString
     * @throws Exception
     */
    public static String decrypt(String cipherText) throws Exception {
        KeyGenerator kgen = KeyGenerator.getInstance("AES");
        kgen.init(128);

        byte[] raw = AesCrypto.STATIC_KEY.getBytes("UTF-8");
        SecretKeySpec skeySpec = new SecretKeySpec(raw, "AES");
        Cipher cipher = Cipher.getInstance(TRANSFORM);

        cipher.init(Cipher.DECRYPT_MODE, skeySpec);
        byte[] original = cipher.doFinal(fromString(cipherText));
        String originalString = new String(original);

        return originalString;
    }

    /**
     * <pre>
     * 1. MethodName : encryptOnly
     * 2. ClassName  : AesCrypto.java
     * 3. Comment    : 단방향 암호화
     * </pre>
     *
     * @param plainText
     * @return output
     * @throws Exception
     */
    public static String encryptOnly(String plainText) throws Exception {
         String output = "";

         StringBuffer sb = new StringBuffer();
         MessageDigest md = MessageDigest.getInstance("SHA-512");

         md.update(plainText.getBytes());
         byte[] msgb = md.digest();

         for (int i = 0; i < msgb.length; i++) {
             byte temp = msgb[i];
             String str = Integer.toHexString(temp & 0xFF);
             while (str.length() < 2) {
                 str = "0" + str;
             }
             str = str.substring(str.length() - 2);
             sb.append(str);
         }

         output = sb.toString();

         return output;
    }

    private static String asHex(byte buf[]) {
        StringBuffer strbuf = new StringBuffer(buf.length * 2);
        int i;

        for (i = 0; i < buf.length; i++) {
            if (((int) buf[i] & 0xff) < 0x10)
                strbuf.append("0");

            strbuf.append(Long.toString((int) buf[i] & 0xff, 16));
        }

        return strbuf.toString();
    }

    private static byte[] fromString(String hex) {
        int len = hex.length();
        byte[] buf = new byte[((len + 1) / 2)];

        int i = 0, j = 0;
        if ((len % 2) == 1)
            buf[j++] = (byte) fromDigit(hex.charAt(i++));

        while (i < len) {
            buf[j++] = (byte) ((fromDigit(hex.charAt(i++)) << 4) | fromDigit(hex
                    .charAt(i++)));
        }
        return buf;
    }

    private static int fromDigit(char ch) {
        if (ch >= '0' && ch <= '9')
            return ch - '0';
        if (ch >= 'A' && ch <= 'F')
            return ch - 'A' + 10;
        if (ch >= 'a' && ch <= 'f')
            return ch - 'a' + 10;

        throw new IllegalArgumentException("invalid hex digit '" + ch + "'");
    }
}
