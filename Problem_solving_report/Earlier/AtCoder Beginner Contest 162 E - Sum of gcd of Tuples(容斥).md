# AtCoder Beginner Contest 162 E - Sum of gcd of Tuples(容斥)

####  题意：

给$n$个数，每个数范围为$[ 1 , k ]$。求这个序列所有可能的情况时$gcd$的和
#### 分析：

枚举$gcd$，设$f[i]$为$gcd$为$i$时有多少种情况。

当$gcd=i$时，每一个位置都有$\lfloor \frac{k}{i} \rfloor$种情况，所有位置都为$i$的倍数的情况数为$(\frac{k}{i})^
n$。但由于是$gcd=i$所以要减去所有位置都为$j*i$的倍数的情况，其中$j∈[2,\frac{k}{i}]$。倒着枚举减掉就好了。

#### 代码：

```C++
#include<bits/stdc++.h>
using namespace std;
#define ll long long
const ll N = 2e5+9 ;
const ll mod = 1e9+7 ;
const ll INF = 1e18 ;
ll ksm( ll a , ll b ){
    ll res = 1 ;
    while( b ){
        if( b&1 ) (res*=a)%= mod ;
        (a*=a)%=mod ;
        b >>= 1 ;
    }
    return res ;
}
void solve(){
    ll n , k ; cin >> n >> k ;
    vector<ll>f(k+1,0) ;
    ll ans = 0 ;
    for( ll i = k ; i >= 1 ; i -- ){
        f[ i ] = ksm( k/i , n ) ;
        for( ll j = 2*i ; j <= k ; j += i ) f[ i ] = ((f[i]-f[j])%mod+mod)%mod ;

        ans = (ans+ (f[i]*i)%mod )%mod ;
    }
    cout << ans << "\n" ;
}
int main(){
    ios::sync_with_stdio(false) ; cin.tie(0) ; cout.tie(0) ;
    ll tt = 1 ; //cin >> tt ;
    while( tt-- ) solve() ;
    return 0 ;
}

```

