#include <iostream>
#include <vector>
#include <sstream>
#include <fstream>
#include <stdlib.h>
//#include <set>

using namespace std;


class Fraction {
	private:
		
		int gcd (int a, int b){
			a = abs(a);
			b = abs(b);
		while (a > 0 && b > 0)
			if	(a > b) a = a % b; 
			else b = b % a;	
			return (a+b);
		}
		
	public:
		int num, den;
		
		Fraction (int a, int b){
			if (a==0){
				num =0;
				den =1;
			}
			else{
				int sign =1 ;
				if (a<0){
					sign *=-1;
					a*=-1;
				}
				if(b<0){
					sign*=-1;
					b*= -1;     			//http://martin-thoma.com/fractions-in-cpp/
				}
			int  tmp = gcd(a,b);
			num = a/tmp*sign;
			den = b/tmp;
		}
		}
		Fraction() {
            num = 0;
            den = 1;
        }
};
		

Fraction operator+(const Fraction& lhs, const Fraction& rhs) {
    Fraction tmp(lhs.num*rhs.den
                +rhs.num*lhs.den,
                lhs.den*rhs.den);
    return tmp;
}
		
		Fraction operator-(const Fraction& lhs, const Fraction& rhs){
			Fraction temp(lhs.num*rhs.den-rhs.num*lhs.den, lhs.den*rhs.den);
			return temp;
		}
		
		Fraction operator* (const Fraction& lhs, const Fraction& rhs){
			Fraction temp (lhs.num*rhs.num, lhs.den*rhs.den);
			return temp;
		}
		
		Fraction operator/ (const Fraction& lhs, const Fraction& rhs){
			Fraction temp (lhs.num*rhs.den, lhs.den*rhs.num);
			return temp;
		}
		
	 Fraction concat (const Fraction& lhs, const Fraction& rhs){
			string res1,res2;
			ostringstream con1,con2;
			con1 << lhs.num;
			res1 = con1.str();
			con2 << rhs.num;
			res2 = con2.str();
			res1.append(res2);
			int random;
			istringstream c(res1);
			c >> random;
		 	Fraction temp(random,1);
		 	return temp;
			
		}
		
std::ostream& operator<<(std::ostream &strm, const Fraction &a) {
    if (a.den == 1) {
        strm << a.num;
    } else {
        strm << a.num << "/" << a.den;
    }
    return strm;
}

vector <Fraction> table[10][10];

	vector<Fraction> comb2(vector <Fraction> list1, vector<Fraction> list2){
		int i, j;
			vector<Fraction> result;

			for(i=0; i< list1.size(); i++){
				for(j=0; j<list2.size(); j++){
				
					result.push_back ( list1[i]+list2[j]);
					result.push_back ( list1[i]-list2[j]);
					result.push_back (list1[i]*list2[j]);
					if ((list2[j]).num != 0) 
						result.push_back ( list1[i]/list2[j]);
				}
			}
			return result;
		
		
	}
	vector<Fraction> combine (vector<Fraction> list1, vector<Fraction> list2){
			int i, j;
			vector<Fraction> result;

			for(i=0; i< list1.size(); i++){
				for(j=0; j<list2.size(); j++){
					if(list1[i].num <10 && list2[j].num<10 && list1[i].den==1 && list2[j].den==1 && list1[i].num>=0 && list2[j].num >=0){
					//	cout<< "list1[i]= "<<list1[i] << " list2[j]= "<< list2[j]<<endl;
						result.insert(result.end(), table[list1[i].num][list2[j].num].begin(), table[list1[i].num][list2[j].num].end());
					}
					else{
				
					result.push_back ( list1[i]+list2[j]);
					result.push_back ( list1[i]-list2[j]);
					result.push_back (list1[i]*list2[j]);
					if ((list2[j]).num != 0) 
						result.push_back ( list1[i]/list2[j]);
				}
				}
			}
		//	set<Fraction> s( result.begin(), result.end() );
		//	result.assign( s.begin(), s.end() );
			return result;
		}
		
	vector<Fraction> find_comb (vector<Fraction> list){
		int size = list.size();
		vector<Fraction> temp,results;
		
		if(size == 1 ) 
				return list;
		else {
			 for(int s=1 ; s<=size-1 ; s++){
				 vector<Fraction> part1(list.begin(), list.begin()+s);
 				vector<Fraction> part2(list.begin()+s, list.end());
 				temp = combine ((find_comb (part1) ),(find_comb (part2)));
 				results.insert( results.end(), temp.begin(), temp.end() );
			}
		}
		return results;			
	}

	vector< vector<int> > numbers (vector<int> list){
		int size = list.size();
		int temp_num;
		vector< vector<int> > temp1, temp2;
		if (size==2){
			vector<vector<int> > res;
			vector<int> temp;
			res.insert(res.begin(),list);
			temp.insert(temp.begin(),list[0]*10+list[1]);
			res.insert(res.begin(),temp);
		
			return res;
		}
		else if(size==1){
			vector< vector<int> > final1;
			final1.insert(final1.begin(),list);
		}
		else{
			temp_num = list.back();
			list.pop_back();
			temp1 = numbers(list);
			temp2 =temp1;
			for(int i=0; i< temp1.size(); i++)
			
				temp1[i].push_back(temp_num);
				
		      for(int i=0 ; i<(int)temp2.size() ; i++)
                        temp2[i][temp2[i].size()-1] = temp2[i][temp2[i].size()-1]*10+temp_num;
                        
			temp1.insert(temp1.end(),temp2.begin(),temp2.end());
		return temp1;	
		}
		vector< vector <int> > wrong;
        return  wrong;
	}
	

		
int main(int argc, char* argv[]){
	int a,temp,i=0,z,s,vector_size;

	cin >> a ;							//gia dekapsifio prepei na balo long int  giati ginetai uperxeilisi!
	vector<Fraction>  tempV;
	vector<int> basic_list;
	vector< vector<int> > pos_combos;
	
	bool f=true;
//	ofstream myfile;
//	myfile.open("example.txt");

	for (int k1=0; k1<10; k1++){
		for(int k2=0; k2<10; k2++){
			vector<Fraction> temp1(1,Fraction(k1,1));
			vector<Fraction> temp2(1,Fraction(k2,1));
			table[k1][k2] = comb2(temp1,temp2);
			
		}
	}
	
	while (a>=10){
		temp = a %10;
		a = a/10;
		
	//	DigitsList.insert (DigitsList.begin(), Fraction (temp,1));
		basic_list.insert(basic_list.begin(),temp);
	}
	//	DigitsList.insert(DigitsList.begin(),Fraction(a,1));
		basic_list.insert(basic_list.begin(),a);
		
		pos_combos = numbers(basic_list);
		cout <<"size="<<pos_combos.size()<<'\n';
		int m=0;
	while( m<pos_combos.size() && f){
		cout<<"current_size="<< pos_combos[m].size()<<'\n';
		vector<Fraction> DigitsList;
		for(int l=0; l<pos_combos[m].size();l++){
			
			DigitsList.push_back(Fraction(pos_combos[m][l],1));
			cout << DigitsList[l] << " ";
		}
		cout<<'\n';
		s=1;
		vector_size=DigitsList.size();
		if(vector_size==1 && DigitsList[0].num==100 && DigitsList[0].den==1 )
			f=false;
	while ( s<= vector_size-1 && f){
		 vector<Fraction> part1(DigitsList.begin(), DigitsList.begin()+s);
 		 vector<Fraction> part2(DigitsList.begin()+s, DigitsList.end());
 		 tempV = combine ((find_comb (part1) ),(find_comb (part2)));
 		 z=0;
 		// cout <<"mpike"<<'\n';
 		while(z<tempV.size() && f){
 			if (tempV[z].num == 100 && tempV[z].den ==1) 
 				f=false;
 			z++;
 			
		 }
		 
		s++;
	}
	m++;
	}
if(f) cout << "final=>true";
else cout<<"final=> false";

cout<<endl;
 system("pause");
 return 0;
}




