@echo off

:: TODO:	����Java��������
:: Author:	yout

color 02
set input=
set /p "input=������JDK�İ�װ·����������Ĭ��ΪC:\Program Files\Java\jdk9.0.4  > "
if defined input (echo JDK������) else (set input=C:\Program Files\Java\jdk9.0.4)
echo,
echo JDK·��Ϊ��%input%
echo,
set javaPath=%input%

:: ����еĻ�����ɾ��JAVA_HOME
wmic ENVIRONMENT where "name='JAVA_HOME'" delete

:: CLASSPATH
wmic ENVIRONMENT where "name='CLASSPATH'" delete

:: ����JAVA_HOME
wmic ENVIRONMENT create name="JAVA_HOME",username="<system>",VariableValue="%javaPath%"

:: ����CLASSPATH
wmic ENVIRONMENT create name="CLASSPATH",username="<system>",VariableValue=".;%%JAVA_HOME%%\lib\dt.jar;%%JAVA_HOME%%\lib\tools.jar"

:: ����PATH
call set xx=%PATH%
wmic ENVIRONMENT where "name='Path' and username='<system>'" set VariableValue="%xx%;%%JAVA_HOME%%\jre\bin;%%JAVA_HOME%%\bin"

pause