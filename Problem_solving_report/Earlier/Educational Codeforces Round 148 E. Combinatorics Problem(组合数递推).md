## Educational Codeforces Round 148 E. Combinatorics Problem

#### 简要题意

回顾一下二项式系数 $ \binom{x}{y} $ 的计算方法（其中 $ x $ 和 $ y $ 是非负整数）：

- 如果 $ x < y $ ，则 $ \binom{x}{y} = 0 $ ；
- 否则，$ \binom{x}{y} = \frac{x!}{y! \cdot (x-y)!} $ 。

给定一个数组 $ a_1, a_2, \dots, a_n $ 和一个整数 $ k $ ，你需要计算一个新数组 $ b_1, b_2, \dots, b_n $ ，其中

- $ b_1 = (\binom{1}{k} \cdot a_1) \bmod 998244353 $ ；
- $ b_2 = (\binom{2}{k} \cdot a_1 + \binom{1}{k} \cdot a_2) \bmod 998244353 $ ；
- $ b_3 = (\binom{3}{k} \cdot a_1 + \binom{2}{k} \cdot a_2 + \binom{1}{k} \cdot a_3) \bmod 998244353 $ ，依此类推。

具体而言，$ b_i = (\sum\limits_{j=1}^{i} \binom{i - j + 1}{k} \cdot a_j) \bmod 998244353 $ 。

注意，数组以一种修改的方式给出，你也需要以一种修改的方式输出。

#### 输入格式

输入的第一行包含六个整数 $ n $ ， $ a_1 $ ， $ x $ ， $ y $ ， $ m $ 和 $ k $ （ $ 1 \le n \le 10^7 $ ； $ 0 \le a_1, x, y < m $ ； $ 2 \le m \le 998244353 $ ； $ 1 \le k \le 5 $ ）。

数组 $ [a_1, a_2, \dots, a_n] $ 的生成方式如下：

- 输入给定了 $ a_1 $ ；
- 对于 $ 2 \le i \le n $ ， $ a_i = (a_{i-1} \cdot x + y) \bmod m $ 。

#### 输出格式

由于输出最多可能有 $ 10^7 $ 个整数，可能会导致速度过慢，因此你需要进行以下处理：

设 $ c_i = b_i \cdot i $ （不在乘法后取模 $ 998244353 $ ）。输出整数 $ c_1 \oplus c_2 \oplus \dots \oplus c_n $ ，其中 $ \oplus $ 表示按位异或运算。

#### 分析：

$$
b_{k,i}& = &\sum_{j=1}^{i} C_{i-j+1}^{k}·a_j \\
	   & = &\sum_{j=1}^{i} C_{i-j}^{k}·a_j + \sum_{j=1}^{i} C_{i-j}^{k-1}·a_j \\
	   & = & \sum_{j=1}^{i-1} C_{(i-1)-j+1}^{k}·a_j + C_{0}^{k}·a_i +  \sum_{j=1}^{i-1} C_{(i-1)-j+1}^{k-1}·a_j + C_{0}^{k-1}·a_i\\
	   & = & b_{k-1,i-1} + b_{k,i-1} + C_{0}^{k}·a_i +C_{0}^{k-1}·a_i
$$



#### 注意：

$C_{0}^0=1$

#### 代码：

```cpp
#include<bits/stdc++.h>
using namespace std ;
#define ll long long
#define double long double
const ll N = 1e7+9 ;
const ll INF = 1e17 ;
const ll mod = 998244353 ;
//const double pi = acos(-1) ;
const double eps = 1e-7 ;
ll gcd( ll a , ll b ){ return a == 0 ? b : gcd( b%a , a ) ; }
ll lcm( ll a , ll b ){ return (a/gcd(a,b))*b ; }
ll Abs( ll x ){ return x < 0 ? -x : x ; }
ll a[ N ] , b[7][N] , n , x , y , m , k ;
void solve(){
    cin >> n >> a[1] >> x >> y >> m >> k ;
    for( int i = 2 ; i <= n ; i ++ ){
        a[ i ] = (a[i-1]*x+y)%m ;
    }

    b[0][1] = a[1] ;
    for( int i = 2 ; i <= n ; i ++ ) b[ 0 ][ i ] = (b[ 0 ][ i-1 ] + a[ i ])%mod ;

    for( int i = 1 ; i <= k ; i ++ )
        for( int j = 1 ; j <= n ; j ++ ){
            b[ i ][ j ] = (b[ i-1 ][ j-1 ] + b[ i ][ j-1 ])%mod ;
            if( i == 1 ) (b[ i ][ j ] += a[ j ] )%=mod ;
    }

    ll ans = 0 ;
    for( int i = 1 ; i <= n ; i ++ ) ans ^= (b[k][i]*i) ;

    cout << ans << "\n" ;

}
int main(){
    ios::sync_with_stdio(false) ; cin.tie(0) ; cout.tie(0) ;
    ll tt = 1 ; //cin >> tt ;
    while( tt-- ) solve() ;
    return 0 ;
}

```

