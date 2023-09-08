## AtCoder Beginner Contest 178 F - Contrast

#### 题意：

​		给出$A$，$B$两个有序数组，长度为$n$，任意排列$B$，问是否有一种方案使得对于所有的$i,(1<=i<=n)$都有$A_i≠B_i$

#### 分析:

​		如果存在某一个数出现的次数大于等于$n+1$,根据鸽巢原理(Pigeonhole Principle)一定无解。

​		设$C[i]$表示$A$数组中值小于或等于$i$的数的出现次数,$D[i]$表示$B$数组中值小于或等于$i$的数的出现次数。

​		将$C[i]$和$D[i]$看作是$x$轴上的点，对于所有的$i(1<=i<=n)$,$(C[i-1],C[i])、(D[i-1],D[i])$形成若干条线段。考虑构造一个$x$，使得对于任意的$i(1<=i<=n)$，都有$(D[i-1]+x,D[i]+1)$与$(C[i-1],C[i])$与$(C[i-1]+n,C[i]+n)$不相交。

![image-20230519212224149](C:\Users\杨阳\AppData\Roaming\Typora\typora-user-images\image-20230519212224149.png)

由三条线段关系得到不等式
$$
\begin{cases}

D[i-1]+x >= C[i] \\
D[i]+x <= C[i-1]+n 

\end{cases}
$$
即
$$
C[i]-D[i-1] <= x <= C[i-1]+n-D[i]
$$
可以证明每一个数在A,B中一共出现的次数小于等于$n$时，合法的$x$一定存在。

#### 证明：

假设$x$不存在，即存在一对$(i,j)$使得 $C[i]-D[i-1] > C[j-1]+n-D[j]$

- 若$i==j$，有$(C[i]-C[i-1])+(D[i]-D[i-1])>n$，即表示某一个数字在$A$和$B$中一共的出现次数大于$n$，这与我们的前提条件不符，所以当$i==j$时假设不成立。
- 若$i<j$，有$(C[i]-C[j-1])+(D[j]-D[i-1])>n$，此时$(C[i]-C[j-1])<=0$，所以$(D[j]-D[i-1]) > n$。但根据定义，$D$数组的值域为$[0,n]$，所以在$i<j$时假设不成立。

- 若$i>j$，$(C[i]-C[j-1])+(D[j]-D[i-1])>n$，此时$(D[j]-D[i-1])<=0$，所以$(C[i]-C[j-1]) > n$。但根据定义，$C$数组的值域为$[0,n]$，所以在$i > j$时假设不成立。

#### 代码：

```cpp
#include<bits/stdc++.h>
using namespace std ;
#define ll long long
#define double long double
const ll N = 1e6+9 ;
const ll INF = 1e17 ;
const ll mod = 998244353 ;
//const double pi = acos(-1) ;
const double eps = 1e-7 ;
ll gcd( ll a , ll b ){ return a == 0 ? b : gcd( b%a , a ) ; }
ll lcm( ll a , ll b ){ return (a/gcd(a,b))*b ; }
ll Abs( ll x ){ return x < 0 ? -x : x ; }
ll n , a[ N ] , b[ N ] , c[ N ] , d[ N ] ;
void solve(){
    cin >> n ;
    for( int i = 1 ; i <= n ; i ++ ){
        cin >> a[ i ] ; c[ a[i] ] ++ ;
    }
    for( int i = 1 ; i <= n ; i ++ ){
        cin >> b[ i ] ; d[ b[i] ] ++ ;
    }

    for( int i = 1 ; i <= n ; i ++ ) if( c[i]+d[i] > n ){
        cout << "No\n" ; return ;
    }

    for( int i = 1 ; i <= n ; i ++ ){
        c[ i ] += c[ i-1 ] ; d[ i ] += d[ i-1 ] ;
    }

    ll l = 0 , r = INF ;
    for( int i = 1 ; i <= n ; i ++ ){
        l = max( l , c[i]-d[i-1] ) ; r = min( r , c[i-1]+n-d[i] ) ;
    }
    if( l > r ){
         cout << "No\n" ; return ;
    }

    cout << "Yes\n" ;
    for( int i = 1 ; i <= n ; i ++ ){
        cout << b[ (((i-l+n)%n==0)?n:((i-l+n)%n))  ] << " " ;
    }
    cout << "\n" ;
}
int main(){
    ios::sync_with_stdio(false) ; cin.tie(0) ; cout.tie(0) ;
    ll tt = 1 ; //cin >> tt ;
    while( tt-- ) solve() ;
    return 0 ;
}



```

