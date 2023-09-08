## Codeforces Round 878 (Div. 3) F. Railguns(DP)

-  #### 题意

--------

​		$Tema$ 在 $n·m$ 的网格内要从 $(0,0)$ 走到 $(n,m)$。第 $0$ 秒末 $Tema$ 位于$(0,0)$。

​		假设 $Tema$ 正位于 $(i,j)$，每秒他可以做三种行动：	

​		①该秒末移动到 $(i+1,j)$；

​		②该秒末移动到 $(i,j+1)$；

​		③该秒末停留在 $(i,j)$。

​		机器人会发射 $r$ 次激光炮以阻挠他前进，具体为在第 $t$ 秒，向第 $x$ 行或第 $x$ 列发射激光炮，一整列或一整行都会受到炮击。若 $Tema$ 在第 $t$ 秒末还停留在被炮击的单元格内则会被击毁。求 $Tema$ 从 $(0,0)$ 到达 $(n,m)$ 的最短时间，若无法抵达，则输出 $-1$。

​		$r$ 次炮击格式为 $t,d,coord$ ，$t$ 表示炮击发生的时间，$d$ 表示炮击方式($d=1$ 时攻击一整行，$d=2$ 时攻击一整列)，$coord$ 表示攻击的是具体哪一行/列。

- #### 分析 

------

​		$Tema$ 在 $(i,j)$ 处会出现的时间在 $[i+j,i+j+r]$ 范围内。

​		如下情况，$Tema$ 在 $(1,1)$ 处出现的时间取到最大值 $i+j+r$。



![image-20230609142114616](C:\Users\杨阳\AppData\Roaming\Typora\typora-user-images\image-20230609142114616.png)

​		所以，设 $dp[i][j][k]$ 表示 $Tema$ 在时间 $i+j+k$ 时能否到达 $(i,j)$。

​		有转移方程
$$
\begin{cases}dp[i][j][k]=dp[i-1][j][k]|dp[i][j][k]&&i>0\\dp[i][j][k]=dp[i][j-1][k]|dp[i][j][k]&&j>0\\dp[i][j][k]=dp[i][j][k-1]|dp[i][j][k]&&i+j+k这个时间没有被炮击\end{cases}
$$

​		检查某个时间某行/列是否被炮击，用 $set$ 维护每行/列被炮击的时间然后二分查找即可。

- #### 代码

-------

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
ll n , m , r ;
void solve(){
    cin >> n >> m >> r ;
    vector<set<ll>>a(n+1),b(m+1) ;
    vector<vector<vector<bool>>>dp(n+1,vector<vector<bool>>(m+1,vector<bool>(r+10,0))) ;
    for( int i = 1 ; i <= r ; i ++ ){
        ll t , d , pos ; cin >> t >> d >> pos ;
        if( d == 2 ) b[pos].insert(t) ;
        if( d == 1 ) a[pos].insert(t) ;
    }

    ll up = min( ( a[0].lower_bound(0+1) == a[0].end() ? r+1 : *a[0].lower_bound(0+1) ) ,
                 ( b[0].lower_bound(0+1) == b[0].end() ? r+1 : *b[0].lower_bound(0+1) )
                ) ;
    //up:大于等于该时间点被炮击的时间，若不存在则取r+1

    for( int i = 0 ; i <= up ; i ++ ) dp[0][0][i] = 1 ;

    for( int i = 0 ; i <= n ; i ++ )
        for( int j = 0 ; j <= m ; j ++ )
            for( int k = 0 ; k <= r ; k ++ ){

                up = min( ( a[i].lower_bound(i+j+k) == a[i].end() ? r+1 : *a[i].lower_bound(i+j+k)-i-j ) ,
                          ( b[j].lower_bound(i+j+k) == b[j].end() ? r+1 : *b[j].lower_bound(i+j+k)-i-j )
                        ) ;

                if( up == k ) dp[i][j][k] = 0 ;
                else{
                    if( i > 0 ) dp[i][j][k] = dp[i][j][k] | dp[i-1][j][k] ;
                    if( j > 0 ) dp[i][j][k] = dp[i][j][k] | dp[i][j-1][k] ;
                    if( k > 0 ) dp[i][j][k] = dp[i][j][k] | dp[i][j][k-1] ;
                }
    }

    for( int i = 0 ; i <= r ; i++ ) if( dp[n][m][i] ){
        cout << n+m+i << "\n" ; return ;
    }
    cout << "-1\n" ; return ;
}
int main(){
    ios::sync_with_stdio(false) ; cin.tie(0) ; cout.tie(0) ;
    ll tt = 1 ; cin >> tt ;
    while( tt-- ) solve() ;
    return 0 ;
}

```

