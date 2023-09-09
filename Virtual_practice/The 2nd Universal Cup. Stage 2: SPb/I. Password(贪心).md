题意：

思路：

代码：

```cpp
#include<bits/stdc++.h>
using namespace std;
#define ll long long
const ll N = 2e6+9 ;

int main(){
    ios::sync_with_stdio(0); cin.tie(0);cout.tie(0);
    ll n ; cin >> n ;
    ll ans1 = 0 , ans2 = n ;
    if( n&1 ){
        ans1 = 2*(n/2/3)+1;
    }
    else{
        ans1 += 2 ;
        ans1 += 2*((n/2-1)/3) ;
    }
    cout << ans1 << " " << ans2 << "\n" ;
    return 0 ;
}
//B = sqrt(n*n/m)
//0 0 0 0 0 0 1 1 0 0 0 0 0 0
```
