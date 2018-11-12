@echo off

:: TODO: 设置Java环境变量
:: Author: yout
:: 使用方法：
:: 		1. 安装好JDK以后，会有两个目录，一个JDK，一个JRE，复制JDK安装路径（如：D:\Java\jdk-10.0.1）
:: 		2. ！！！右键点击管理员运行此文件！！！
:: 		3. 粘贴第（1）步复制的路径，回车确认开始设置环境变量。
:: 		* 4. 保险起见，设置完毕后自行查看变量是否设置正确，打开cmd输入java --version和javac --version看是否有版本信息输出

color 02
set input=
set /p "input=请输入JDK的安装路径，留空则默认为：  C:\Program Files\Java\jdk9.0.4  > "
if defined input (echo JDK已设置) else (set input=C:\Program Files\Java\jdk9.0.4)
echo,
echo JDK路径为： %input%
echo,
set javaPath=%input%

:: 如果有的话，先删除JAVA_HOME
wmic ENVIRONMENT where "name='JAVA_HOME'" delete

:: CLASSPATH
wmic ENVIRONMENT where "name='CLASSPATH'" delete

:: 创建JAVA_HOME
wmic ENVIRONMENT create name="JAVA_HOME",username="<system>",VariableValue="%javaPath%"

:: 创建CLASSPATH
wmic ENVIRONMENT create name="CLASSPATH",username="<system>",VariableValue=".;%%JAVA_HOME%%\lib\dt.jar;%%JAVA_HOME%%\lib\tools.jar"

:: 更新PATH
call set xx=%PATH%
wmic ENVIRONMENT where "name='Path' and username='<system>'" set VariableValue="%xx%;%%JAVA_HOME%%\jre\bin;%%JAVA_HOME%%\bin"

pause