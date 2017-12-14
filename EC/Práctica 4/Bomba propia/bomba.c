#include <stdio.h>	// para printf()
#include <stdlib.h>	// para exit()
#include <string.h>	// para strncmp()/strlen()
#include <sys/time.h>	// para gettimeofday(), struct timeval

char password[]="cuervoinsurgente\n";
int  passcode  = 4593;

void boom(){
	printf("***************\n");
	printf("*** BOOM!!! ***\n");
	printf("***************\n");
	exit(-1);
}

void defused(){
	printf("·························\n");
	printf("··· bomba desactivada ···\n");
	printf("·························\n");
	exit(0);
}

int moduloNadaSospechoso(int num){
	num=num-52;
	return num;
}

int main(){
#define SIZE 100
	char pass[SIZE];
	int  pasv;
#define TLIM 5
	struct timeval tv1,tv2;	// gettimeofday() secs-usecs

	gettimeofday(&tv1,NULL);

	printf("Introduce la contraseña: ");
	
	fgets(pass,SIZE,stdin);
	for(int i=0;i<16;i++){
		if(pass[i]!= password[i])
			boom();
	}
		

	gettimeofday(&tv2,NULL);
	if (tv2.tv_sec - tv1.tv_sec > TLIM)
	    boom();

	printf("Introduce el código: ");
	scanf("%i",&pasv);
	
	pasv=moduloNadaSospechoso(pasv);
	if (pasv!=passcode) boom();

	gettimeofday(&tv1,NULL);
	if (tv1.tv_sec - tv2.tv_sec > TLIM)
	    boom();

	defused();
}
