开多个map见祖宗

原来斜率可以映射成一个整数，没必要用三元组

```cpp
#pragma GCC optimize(2)
#include<bits/stdc++.h>
using namespace std ;
#define ll long long
const ll N = 2e3+9 ;
const ll inf = 3e9+9 ;
int Abs( int x ){ return x < 0 ? -x : x ; }
inline int gcd(int a,int b){return b==0?a:gcd(b,a%b);}
struct point{
    int x , y ;
}p[ N ],Q[N];
int n , q , ans [ N ] ;
unordered_map<ll,int>now;
unordered_map<ll,int>mp[ N ] ;
pair<int,int>k;
void Cal_k( point p1 , point p2 ){
    int A = p2.y-p1.y , B = p2.x-p1.x ;

    int g = gcd( Abs(A) , Abs(B) ) ;
    A /= g ; B /= g ;

    k = { A , B } ;
}
inline ll HASH( pair<int,int>kk ){
    return ((ll)kk.first)*inf+kk.second ;
}
int main(){
    ios::sync_with_stdio(false) ; cin.tie(0) ; cout.tie(0) ;
    cin >> n >> q ;
    for( int i = 1 ; i <= n ; i ++ ) cin >> p[i].x >> p[i].y ;

    for( int i = 1 ; i <= n ; i ++ )
    {
        for( int j = 1 ; j <= n ; j ++ ) if( j != i )
        {
            Cal_k( p[i] , p[j] ) ;
            ll K = HASH(k) ;
            mp[ i ][ K ] ++ ;
        }
    }

    for( int i = 1 ; i <= q ; i ++ ) cin >> Q[i].x >> Q[i].y ;

    for( int i = 1 ; i <= q ; i ++ )
    {
        now.clear() ;
        for( int j = 1 ; j <= n ; j ++ )
        {
            Cal_k( p[j] , Q[i] ) ;

            ll K1 = HASH(k) ;
            ll K2 = HASH( {-k.second,k.first} )  ;
            ll K3 = HASH( {k.second,-k.first} )  ;

            ans[i] += now[ K2 ] ; // A作为直角
            ans[i] += now[ K3 ] ;
            now[ K1 ] ++ ;
        }
    }

    //for( int i = 1 ; i <= q ; i ++ ) cout << ans[ i ] << " " ; cout << "\n" ;

    for( int i = 1 ; i <= n ; i ++ )
    {
        now.clear() ;
        for( int j = 1 ; j <= n ; j ++ ) if( j != i )
        {
            Cal_k( p[j] , p[i] ) ;
            ll K1 = HASH(k) ;
            now[K1] ++ ;
        }
        for( int j = 1 ; j <= q ; j ++ )
        {
            Cal_k( p[i] , Q[j] ) ;
            ll K2 = HASH( {-k.second,k.first} )  ;
            ll K3 = HASH( {k.second,-k.first} )  ;
            ans[j] += now[ K2 ] ; // A作为直角
            ans[j] += now[ K3 ] ;
        }
    }

    for( int i = 1 ; i <= q ; i ++ ) cout << ans[ i ] << "\n" ;
    return 0 ;
}
```
