@echo off

:: TODO: ����Java��������
:: Author: yout
:: ʹ�÷�����
:: 		1. ��װ��JDK�Ժ󣬻�������Ŀ¼��һ��JDK��һ��JRE������JDK��װ·�����磺D:\Java\jdk-10.0.1��
:: 		2. �������Ҽ��������Ա���д��ļ�������
:: 		3. ճ���ڣ�1�������Ƶ�·�����س�ȷ�Ͽ�ʼ���û���������
:: 		* 4. ���������������Ϻ����в鿴�����Ƿ�������ȷ����cmd����java --version��javac --version���Ƿ��а汾��Ϣ���

color 02
set input=
set /p "input=������JDK�İ�װ·����������Ĭ��Ϊ��  C:\Program Files\Java\jdk9.0.4  > "
if defined input (echo JDK������) else (set input=C:\Program Files\Java\jdk9.0.4)
echo,
echo JDK·��Ϊ�� %input%
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