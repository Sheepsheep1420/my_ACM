```cpp

#include<bits/stdc++.h>
#define ll long long
#define inff 0x3f3f3f3f3f3f3f3f
using namespace std ;
const ll N=1e5+100;
int main()
{
    ios::sync_with_stdio(false) ; cin.tie(0) ; cout.tie(0) ;
    int n ; cin >> n ;
    string s ; cin >> s ; s = "?" + s ;
    string ans = "" ;
    for( int i = n ; i >= 1 ; i -- )
    {
        string res = "" ;
        map<char,char>mp;
        vector<bool>vis(30,0) ;
        int cnt = 0 ;
        for( int j = i ; j >= 1 ; j -- )
        {
            if( !vis[ s[j]-'a' ] )
            {
                mp[ s[j] ] = 'a' + cnt ;

                vis[ s[j]-'a' ] = 1 ;
                cnt ++ ;
            }
        }
        for( int j = 1 ; j <= i ; j ++ ) res.push_back( mp[ s[j] ] ) ;

        if( ans < res ) ans = res ;
    }
    cout << ans << "\n" ;
    return 0 ;
}
```
