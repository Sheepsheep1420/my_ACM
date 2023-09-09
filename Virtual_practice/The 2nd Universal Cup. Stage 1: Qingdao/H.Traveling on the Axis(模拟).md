题意：

思路：

代码：

```cpp
#include<bits/stdc++.h>
using namespace std;
#define ll long long
const ll N = 2e6+9 ;
void solve(){
    ll n ; string s ; cin >> s ; n = s.size() ;
    ll sum1 = 1 , sum0 = 0 , ans = 0 ;
    for( int i = 0 ; i < n ; i ++ ){
        ll tot = n-i ; //后面的点
        if( s[i] == '0' ){//红灯
            ans += sum1*tot ;
            swap( sum1 , sum0 ) ;
            sum1 += sum0 ; sum0 = 0 ;
        }
        else{
            ans += sum0*tot ;
            swap( sum1 , sum0 ) ;
            sum0 += sum1 ; sum1 = 0 ;
        }
        sum1 ++ ;
        ans += ((1+tot)*tot)/2;
    }
    cout << ans << "\n" ;
}
int main(){
    ios::sync_with_stdio(0); cin.tie(0);cout.tie(0);
    ll tt = 1 ; cin >> tt ;
    while( tt-- ) solve() ;
    return 0 ;
}
//B = sqrt(n*n/m)
```
