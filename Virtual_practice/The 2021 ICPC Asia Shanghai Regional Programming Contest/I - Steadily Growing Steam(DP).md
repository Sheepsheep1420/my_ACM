
先考虑不翻倍的情况，再推广到翻倍k个的情况

```cpp
#include<bits/stdc++.h>
#define ll long long
using namespace std;
const ll N = 1e4+10 ;
const ll mod = 998244353;
ll f[ 105 ][ 6000 ][ 105 ] , n , m , a[ N ] , b[ N ] ;
int main(){
	cin >> n >> m ;
	for( int i = 1 ; i <= n ; i ++ ) cin >> a[ i ] >> b[ i ] ;

    ll mid = 2700 , up = 5400 ;

    for( int i = 0 ; i <= n ; i ++ )
        for( int j = 0 ; j <= up ; j ++ )
            for( int k = 0 ; k <= m ; k ++ )
                f[i][j][k] = -10000000000000 ;

    f[0][mid][0] = 0 ;

    for( int i = 1 ; i <= n ; i ++ )
    {
        for( int j = 0 ; j <= up ; j ++ ) //A
        {
            for( int k = 0 ; k <= m ; k ++ )
            {
                if( j >= b[i] ) f[i][j][k] = max( f[i][j][k] , f[i-1][j-b[i]][k]+a[i] ) ; // A
                if( j+b[i] <= up ) f[i][j][k] = max( f[i][j][k] , f[i-1][j+b[i]][k]+a[i] ) ; // B
                f[i][j][k] = max( f[i-1][j][k] , f[i][j][k] ) ;

                if( k >= 1 )
                {
                    if( j >= 2*b[i] ) f[i][j][k] = max( f[i][j][k] , f[i-1][j-2*b[i]][k-1]+a[i] ) ; // A
                    if( j+2*b[i] <= up ) f[i][j][k] = max( f[i][j][k] , f[i-1][j+2*b[i]][k-1]+a[i] ) ; // B
                }
            }
        }

        //cout << "i=" << i << "\n" ;
        //for( int j = mid-5 ; j <= mid+5 ; j ++ ) cout << f[i][j] << " " ; cout << "\n" ;
    }

    ll ans = -10000000000000 ;
    for( int k = 0 ; k <= m ; k ++ ) ans = max( ans , f[n][mid][k] ) ;

    cout << ans << "\n" ;
///////////////
	return 0;
}

```
