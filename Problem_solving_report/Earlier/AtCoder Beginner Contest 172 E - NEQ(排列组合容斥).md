## AtCoder Beginner Contest 172 E - NEQ(排列组合/容斥)

#### 题意:

构造包含$N$个数的序列$E$，$F$，其中各项取值范围为$[1,M]$ ，求满足如下要求的构造方法数量。

- $E_i ≠ F_i ， 对于任意的 i ， 1 \leq i \leq N $ .
- $E_i ≠ E_j 并且 F_i ≠ F_j ， 对于任意的(i,j) ，1 \leq i < j  \leq N $.

#### 分析:

​		首先确定$E$集合，有$A_m^n$种方案	

​		接下来确定$F$集合，若不考虑条件$①$，也有$A_m^n $种方案，但要剔除一些。

![img](https://cdn.luogu.com.cn/upload/image_hosting/tr282inv.png)

所以不合法的方案数$G$。
$$
G = | T_1 \cup T_2 \cup ··· \cup T_n | \\
=\sum_{i=1}^{n}|T_i| - \sum_{i=1}^{n}\sum_{j=1,j≠i}^{n}|T_i\cap T_j| + ··· ± |T_1 \cap T_2 \cap ··· \cap T_n |
$$
上式容斥来算。

具体来说，$k$个$T$类集合的交集即为：构造$F$集合时，固定住$k$个数，除了这$k$个位置，其他位置的值大小在$[1,m]$之间且互不相同的方案数。
$$
k个T类集合的交集大小=C_n^k · A_{m-k}^{n-k}
$$
所以最后的答案为
$$
A_{m}^{n}·(A_{m}^{n}-G)
$$

#### 代码：

```cpp
#include<bits/stdc++.h>
using namespace std ;
#define ll long long
#define double long double
const ll N = 1e6+9 ;
const ll INF = 1e17 ;
const ll mod = 1e9+7 ;
//const double pi = acos(-1) ;
const double eps = 1e-7 ;
ll gcd( ll a , ll b ){ return a == 0 ? b : gcd( b%a , a ) ; }
ll lcm( ll a , ll b ){ return (a/gcd(a,b))*b ; }
ll Abs( ll x ){ return x < 0 ? -x : x ; }
ll exgcd( ll a , ll b , ll &x , ll &y ){
    if( a%b == 0 ){
        x = 0 ; y = 1 ; return b ;
    }
    ll r , tx , ty ;
    r = exgcd( b , a%b , tx , ty ) ;
    x = ty ; y = tx-a/b*ty ;
    return r ;
}
ll ksm( ll a , ll b ){
    ll res = 1 ;
    while( b ){
        if( b&1 ) (res*=a)%=mod ;
        b >>= 1 ;
        (a*=a)%=mod ;
    }
    return res ;
}
ll f[ N ] , inv[ N ] ;
ll C( ll a , ll b ){
    ll res = (f[a]*inv[a-b])%mod ;
    res = (res*inv[b])%mod ;
    return res ;
}
ll A( ll a , ll b ){
    ll res = (f[a]*inv[a-b])%mod ;
    return res ;
}
void solve(){
    f[ 0 ] = inv[ 0 ] = 1 ;
    for( ll i = 1 ; i < N ; i ++ ) f[i] = (f[i-1]*i)%mod ;
    inv[N-1] = ksm(f[N-1],mod-2) ;
    for( ll i = N-2 ; i >= 1 ; i -- ) inv[i] = (inv[i+1]*(i+1))%mod ;

    ll n , m , sig = 1 ; cin >> n >> m ;

    ll E = A(m,n) , F = A(m,n) , G = 0 ;
    for( int i = 1 ; i <= n ; i ++ ){
        G=( ( G + (sig*C(n,i)*A(m-i,n-i))%mod )%mod + mod )%mod;
        sig *= -1 ;
    }

    F = ((F-G)%mod + mod )%mod ;
    cout << (E*F)%mod << "\n" ;
}
int main(){
    ios::sync_with_stdio(false) ; cin.tie(0) ; cout.tie(0) ;
    ll tt = 1 ; //cin >> tt ;
    while( tt-- ) solve() ;
    return 0 ;
}



```

