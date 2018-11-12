@echo off

:: TODO:	设置Java环境变量
:: Author:	yout

color 02
set input=
set /p "input=请输入JDK的安装路径，留空则默认为C:\Program Files\Java\jdk9.0.4  > "
if defined input (echo JDK已设置) else (set input=C:\Program Files\Java\jdk9.0.4)
echo,
echo JDK路径为：%input%
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