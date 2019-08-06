#include <stdio.h>


void find_sum ( int array[]){
	int i=0; int a, b, c,k;
	int temp_sum;
	for (i=0; i<729; i++){							//finds all happy-unhappy numbers from 1 - 729 (sum of 999 999 999 => 9^3=729 max sum)
			temp_sum=i+1;
		while (array[temp_sum - 1]==2){
			a=(temp_sum/100);
			k=(temp_sum % 100);
			b= (k/10);
			c=(k % 10);

			temp_sum = a*a + b*b + c*c;
			
		}

		if (array[temp_sum-1]==1)
			array[i]=1;		
		else
			array[i]=0;
	}
}


void sum_ten_tho (int array[]){
	for(int k=1; k<=100000; k++){		//briskei to sum ton proton 10000 arithmon
		int s=0, dig, j=k;
		while (j>0){
			dig=j%10;
			j=j/10;
			s=s+dig*dig;
		}
		array[k]=s;
		
	}
}


int main(void){
	int a, b,i;
	int sum_array[729], sum_tenth[100001];
	int num=0, k,m;
	FILE *fp;
	fp=fopen ("test.txt", "r");			//den xero pos legontai ta arxeia
	fscanf (fp, "%d %d", &a, &b);
	
	for (int i=0; i<729; i++){
		sum_array[i]=2;				//2= i dont know if it;s happy or unhappy
	}
	sum_array[3]=0;   				//0=unhappy, unhappy numbers in loop: 4,16,37,58,89,145,42,20
	sum_array[15]=0;
	sum_array[36]=0;
	sum_array[57]=0;
	sum_array[88]=0;
	sum_array[144]=0;
	sum_array[41]=0;
	sum_array[19]=0;
	sum_array[0]=1; 				//1=happy ---- 1, 10,100 are happy numbers
	sum_array[9]=1;
	sum_array[99]=1;
	
	find_sum ( sum_array);         //find sum from 1 to 729- if they are happy numbers

	for( i=0; i<100001; i++){
		sum_tenth[i]=0;
	}
	sum_ten_tho (sum_tenth);		 //to sum_tenth exei ola ta athroismata ton arithmon apo 1 eos 100.000

	for(i=a; i<=b; i++){
		k= i/100000;
		m= i%100000;
		num+= sum_array[sum_tenth[k]+sum_tenth[m]-1];

	}
	
	printf("num=%d\n", num);
	fclose(fp);
	return 0;
	
}
