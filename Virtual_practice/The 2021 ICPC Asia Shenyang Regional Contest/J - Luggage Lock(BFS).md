```cpp
#include<bits/stdc++.h>
#define ll long long
using namespace std ;
struct node{
    int v[4] ;
};
int f[20][20][20][20] ;
node Do( node now , int l , int r , int val )
{
    node res = now ;
    for( int i = 0 ; i < 4 ; i ++ )
    {
        if( i >= l && i <= r )
        {
            res.v[ i ] += val ;
            res.v[ i ] = (res.v[ i ]+10)%10;
        }
    }
    return res ;
}
void init()
{
    memset( f , 127 , sizeof f ) ;

    node now = {{0,0,0,0}}; f[0][0][0][0] = 0 ;
    node Next ;
    int w ;

    queue<node>q ; q.push( now ) ;

    while( !q.empty() )
    {
        now = q.front() ; q.pop() ;

        for( int len = 1 ; len <= 4 ; len ++ )
        {
            for( int l = 0 , r = len-1 ; r < 4 ; l++ , r ++ )
            {
               Next = Do( now , l , r , 1 ) ;
               w = f[ now.v[0] ][ now.v[1] ][ now.v[2] ][ now.v[3] ] + 1 ;
               if( w < f[ Next.v[0] ][ Next.v[1] ][ Next.v[2] ][ Next.v[3] ] )
               {
                   q.push( Next ) ;
                   f[ Next.v[0] ][ Next.v[1] ][ Next.v[2] ][ Next.v[3] ] = w ;
               }

               Next = Do( now , l , r , -1 ) ;
               w = f[ now.v[0] ][ now.v[1] ][ now.v[2] ][ now.v[3] ] + 1 ;
               if( w < f[ Next.v[0] ][ Next.v[1] ][ Next.v[2] ][ Next.v[3] ] )
               {
                   q.push( Next ) ;
                   f[ Next.v[0] ][ Next.v[1] ][ Next.v[2] ][ Next.v[3] ] = w ;
               }
            }
        }

    }

}
void solve()
{
    node a , b ;
    string A , B ;
    cin >> A >> B ;

    for( int i = 0 ; i < 4 ; i ++ )
    {
        a.v[ i ] = A[i]-'0' ;
        b.v[ i ] = B[i]-'0' ;
    }

    for( int i = 0 ; i < 4 ; i ++ )
    {
        b.v[i] = (b.v[i]-a.v[i]+10)%10;
    }

    cout << f[ b.v[0] ][ b.v[1] ][ b.v[2] ][ b.v[3] ] << "\n" ;

}
int main()
{
    ios::sync_with_stdio(0);cin.tie(0);cout.tie(0);

    init() ;

    ll tt ; cin >> tt ;
    while( tt-- ) solve() ;
    return 0 ;
}

```
