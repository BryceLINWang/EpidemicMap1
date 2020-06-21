<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.net.URLConnection"%>
<%@page import="java.net.URL"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta charset="UTF-8">
<title>疫情地图</title>
<script type="text/javascript">
	<%!
		//这里的代码，只会在第一个用户访问时执行
		// 用于缓存每次读取的疫情数据
		String text;
		// 时间戳：格林威治历（1970-1-1 00：00）开始到目前的毫秒数字（13位数字）,System.currentTimeMillis()
		// 用于表示时间
		long time = 0;
	%>
	<%
		if(System.currentTimeMillis()-time>600000){
			//每次获取数据，更新时间戳为获取数据前的时间戳
			time = System.currentTimeMillis();
			//1.	创建一个URL类的对象url (导包：光标移入类型最后，alt+/)
			URL url = new URL("https://zaixianke.com/yq/all");
			//2.	通过URL类的对象url打开网络连接 , 并得到连接对象conn
			URLConnection conn = url.openConnection();
			//3.	通过连接对象 , 得到用于读取网页内容的输入流 is
			InputStream is = conn.getInputStream();
			//4.	将上述的字节流is 装饰为字符流 , 将字符流再装饰为一次能读取一行的字符流br
			BufferedReader br = new BufferedReader(new InputStreamReader(is,"UTF-8"));
			//5.	通过字符流br,读取一行内容,并将内容存储到变量text中
			text = br.readLine();
		}
			//6.	可以将读取到的疫情内容text 输出到JS的变量data位置
			
	%>
    		var data = <%=text%>;
</script>
<script src="https://cdn.bootcss.com/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdn.bootcss.com/echarts/4.7.0/echarts.min.js"></script> 
<script src="http://cdn.zaixianke.com/china.js"></script>
<script src="http://cdn.zaixianke.com/world.js"></script>
</head>
<body>
<div id="main" style="width: 100%;height:600px;"></div> <br>
<div style="text-align:center">
		<a style="color:#333" class="control" align="center" href="javascript:updateMap(0)">国内累计</a>
		<a style="color:#333" class="control" align="center" href="javascript:updateMap(1)">国内新增</a>
		<a style="color:#333" class="control" align="center" href="javascript:updateMap(2)">全球累计</a>
		<a style="color:#333" class="control" align="center" href="javascript:updateMap(3)">全球新增</a>
</div>
<script src="control.js"></script>
</body>
</html>