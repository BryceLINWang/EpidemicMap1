package com.edu.map;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;

/**
 * 读疫情数据
 */
public class Demo {
    public static void main(String[] args) throws IOException {
        //1.	创建一个URL类的对象url
        URL url = new URL("https://zaixianke.com/yq/all");
        try {
            SslUtils.ignoreSsl();
        } catch (Exception e) {
            e.printStackTrace();
        }
        //2.	通过URL类的对象url打开网络连接 , 并得到连接对象conn
        URLConnection conn = url.openConnection();
        //3.	通过连接对象 , 得到用于读取网页内容的输入流 is
        InputStream is = conn.getInputStream();
        //4.	将上述的字节流is 装饰为字符流 , 将字符流再装饰为一次能读取一行的字符流br
        BufferedReader br = new BufferedReader(new InputStreamReader(is,"UTF-8"));
        //5.	通过字符流br,读取一行内容,并将内容存储到变量text中
        String text1 = br.readLine();
        //6.	可以将读取到的内容text 输出显示到控制台
        System.out.println(text1);
    }
}
