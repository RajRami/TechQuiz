package com.techquiz.helper;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;

public class Helper {
    public static void deleteFile(String path) {
        try {
            File file = new File(path);
            file.delete();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void saveFile(InputStream inputStream, String path) {
        try {
            byte b[] = new byte[inputStream.available()];
            inputStream.read(b);
            FileOutputStream fileOutputStream = new FileOutputStream(path);
            fileOutputStream.write(b);
            fileOutputStream.flush();
            fileOutputStream.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
