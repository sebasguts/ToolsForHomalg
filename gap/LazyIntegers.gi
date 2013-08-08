#############################################################################
##
##  LazyIntegers.gi                                 ToolsForHomalg package
##
##  Copyright 2007-2013, Mohamed Barakat, University of Kaiserslautern
##                       Sebastian Gutsche, RWTH-Aachen University
##                  Markus Lange-Hegermann, RWTH-Aachen University
##
##  The right integers for homalg.
##
#############################################################################

DeclareRepresentation( "IsLazyIntegerRep",
                       IsLazyInteger and IsAttributeStoringRep,
                       []
                     );

DeclareRepresentation( "IsLazyIntegersMinusInfinityRep",
                       IsLazyInteger and IsAttributeStoringRep,
                       []
                     );

DeclareRepresentation( "IsLazyIntegersInfinityRep",
                       IsLazyInteger and IsAttributeStoringRep,
                       []
                     );

BindGlobal( "TheFamilyOfLazyIntegers",
        NewFamily( "TheFamilyOfLazyIntegers" ) );

BindGlobal( "TheTypeLazyInteger",
        NewType( TheFamilyOfLazyIntegers,
                IsLazyIntegerRep ) );

BindGlobal( "TheTypeLazyIntegerMinusInfinity",
        NewType( TheFamilyOfLazyIntegers,
                IsLazyIntegersMinusInfinityRep ) );

BindGlobal( "TheTypeLazyIntegerInfinity",
        NewType( TheFamilyOfLazyIntegers,
                IsLazyIntegersInfinityRep ) );

#########################
##
## Constructors
##
#########################

##
InstallGlobalFunction( LazyIntegers_Main_Constructor,
                       
  function( intervall_list )
    local integer;
    
    if not IsList( intervall_list ) or not ForAll( intervall_list, i -> IsList( i ) and Length( i ) = 2 ) then
        
        Error( "input is not a list of intervalls." );
        
    fi;
    
    integer := rec( intervalls := intervall_list,
                    is_summand_of := [ ],
                    is_factor_of := [ ],
                    sum_with_int := [ ],
                    prod_with_int := [ ],
                    equals := [ ],
    );
    
    Objectify( TheTypeLazyInteger, integer );
    
    return integer;
    
end );

##
InstallMethod( LazyInteger,
               "without bounds",
               [ ],
               
  function( )
    
    return LazyIntegers_Main_Constructor( [ [ LazyIntegers_Minus_Infinity, LazyIntegers_Infinity ] ] );
    
end );

##
InstallMethod( LazyInteger,
               "with list of intervalls",
               [ IsList ],
               
  function( list )
    
    return LazyIntegers_Main_Constructor( list );
    
end );

##
InstallMethod( LazyIntegerWithLowerBound,
               "with lower bound",
               [ IsInt ],
               
  function( low )
    
    return LazyIntegers_Main_Constructor( [ [ low, LazyIntegers_Infinity ] ] );
    
end );

##
InstallMethod( LazyIntegerWithUpperBound,
               "with upper bound",
               [ IsInt ],
               
  function( up )
    
    return LazyIntegers_Main_Constructor( [ [ LazyIntegers_Minus_Infinity, up ] ] );
    
end );

#########################
##
## Update
##
#########################

##
InstallGlobalFunction( LazyIntegers_Update_Not_Equal,
                       
  function( x, not_equal )
    local i;
    
    for i in x!.sum_with_int do
        
        SetNotEqualTo( i[ 1 ], not_equal + i[ 2 ] );
        
    od;
    
    for i in x!.equals do
        
        SetNotEqualTo( i, not_equal );
        
    od;
    
end );

##
InstallGlobalFunction( LazyIntegers_Update_Lower_Bound,
                       
  function( x, bound, old_bound )
    local summands, summand_of, i, current_bound, factors, new_intervalls;
    
    ## Sum
    
    if IsBound( x!.summands ) then
    
    fi;
    
    for i in x!.is_summand_of do
        
        SetLowerBound( i, CurrentLowerBound( i ) - old_bound + bound );
        
    od;
    
    ## Product. Needs to be completely redone.
    
    for i in x!.is_factor_of do
        
        factors := i!.factors;
        
        new_intervalls := Concatenation( List( factors[ 1 ]!.intervalls, i -> List( factors[ 2 ]!.intervalls, j -> LazyIntegers_Intervall_Mult( i, j ) ) ) );
        
        SetBounds( i, [ Minimum( List( new_intervalls, k -> k[ 1 ] ) ), Maximum( List( new_intervalls, k -> k[ 2 ] ) ) ] );
        
    od;
    
    for i in x!.sum_with_int do
        
        SetLowerBound( i[ 1 ], i[ 2 ] + bound );
        
    od;
    
    for i in x!.equals do
        
        SetLowerBound( i, bound );
        
    od;
    
end );

##
InstallGlobalFunction( LazyIntegers_Update_Upper_Bound,
                       
  function( x, bound, old_bound )
    local summands, summand_of, i, current_bound, factors, new_intervalls;
    
    ## Sum
    
    if IsBound( x!.summands ) then
    
    fi;
    
    for i in x!.is_summand_of do
        
        SetUpperBound( i, CurrentUpperBound( i ) - old_bound + bound );
        
    od;
    
    ## Product. Needs to be completely redone.
    
    for i in x!.is_factor_of do
        
        factors := i!.factors;
        
        new_intervalls := Concatenation( List( factors[ 1 ]!.intervalls, i -> List( factors[ 2 ]!.intervalls, j -> LazyIntegers_Intervall_Mult( i, j ) ) ) );
        
        SetBounds( i, [ Minimum( List( new_intervalls, k -> k[ 1 ] ) ), Maximum( List( new_intervalls, k -> k[ 2 ] ) ) ] );
        
    od;
    
    for i in x!.sum_with_int do
        
        SetUpperBound( i[ 1 ], i[ 2 ] + bound );
        
    od;
    
    for i in x!.equals do
        
        SetUpperBound( i, bound );
        
    od;
    
end );

#########################
##
## (minus) infinity
##
#########################

InstallValue( LazyIntegers_Minus_Infinity,
              rec( intervalls := [ LazyIntegers_Minus_Infinity, LazyIntegers_Minus_Infinity ],
                   is_summand_of := [ ],
                   is_factor_of := [ ],
                 ) );

Objectify( TheTypeLazyIntegerMinusInfinity, LazyIntegers_Minus_Infinity );

InstallValue( LazyIntegers_Infinity,
              rec( intervalls := [ LazyIntegers_Infinity, LazyIntegers_Infinity ],
                   is_summand_of := [ ],
                   is_factor_of := [ ],
              ) );

Objectify( TheTypeLazyIntegerInfinity, LazyIntegers_Infinity );

##
InstallMethod( \<,
               "for infinity",
               [ IsInt, IsLazyIntegersInfinityRep ],
               
  ReturnTrue
  
);

##
InstallMethod( \<,
               "for infinity",
               [ IsLazyIntegersInfinityRep, IsInt ],
               
  ReturnFalse
  
);

##
InstallMethod( \<,
               "for infinity",
               [ IsInt, IsLazyIntegersMinusInfinityRep ],
               
  ReturnFalse
  
);

##
InstallMethod( \<,
               "for infinity",
               [ IsLazyIntegersMinusInfinityRep, IsInt ],
               
  ReturnTrue
  
);

##
InstallMethod( \+,
               "for infinity",
               [ IsInt, IsLazyIntegersInfinityRep ],
               
  function( x, y )
    
    return y;
    
end );

##
InstallMethod( \+,
               "for infinity",
               [ IsLazyIntegersInfinityRep, IsInt ],
               
  function( x, y )
    
    return x;
    
end );

##
InstallMethod( \+,
               "for infinity",
               [ IsInt, IsLazyIntegersMinusInfinityRep ],
               
  function( x, y )
    
    return y;
    
end );

##
InstallMethod( \+,
               "for infinity",
               [ IsLazyIntegersMinusInfinityRep, IsInt ],
               
  function( x, y )
    
    return x;
    
end );

##
InstallMethod( \-,
               "for infinity",
               [ IsInt, IsLazyIntegersInfinityRep ],
               
  function( x, y )
    
    return LazyIntegers_Minus_Infinity;
    
end );

##
InstallMethod( \-,
               "for infinity",
               [ IsLazyIntegersInfinityRep, IsInt ],
               
  function( x, y )
    
    return x;
    
end );

##
InstallMethod( \-,
               "for infinity",
               [ IsInt, IsLazyIntegersMinusInfinityRep ],
               
  function( x, y )
    
    return LazyIntegers_Infinity;
    
end );

##
InstallMethod( \-,
               "for infinity",
               [ IsLazyIntegersMinusInfinityRep, IsInt ],
               
  function( x, y )
    
    return x;
    
end );

##
InstallMethod( \*,
               "for infinity",
               [ IsInt, IsLazyIntegersInfinityRep ],
               
  function( x, y )
    
    if x < 0 then
        
        return LazyIntegers_Minus_Infinity;
        
    elif x > 0 then
        
        return LazyIntegers_Infinity;
        
    else
        
        return 0;
        
    fi;
    
end );

##
InstallMethod( \*,
               "for infinity",
               [ IsLazyIntegersInfinityRep, IsInt ],
               
  function( x, y )
    
    return y * x;
    
end );

##
InstallMethod( \*,
               "for infinity",
               [ IsInt, IsLazyIntegersMinusInfinityRep ],
               
  function( x, y )
    
    if x < 0 then
        
        return LazyIntegers_Infinity;
        
    elif x > 0 then
        
        return LazyIntegers_Minus_Infinity;
        
    else
        
        return 0;
        
    fi;
    
end );

##
InstallMethod( \*,
               "for infinity",
               [ IsLazyIntegersMinusInfinityRep, IsInt ],
               
  function( x, y )
    
    return y * x;
    
end );

##
InstallMethod( CurrentLowerBound,
               "for lazy integers",
               [ IsLazyIntegerRep ],
               
  function( x )
    
    return Minimum( List( x!.intervalls, i -> i[ 1 ] ) );
    
end );

##
InstallMethod( CurrentUpperBound,
               "for lazy integers",
               [ IsLazyIntegerRep ],
               
  function( x )
    
    return Maximum( List( x!.intervalls, i -> i[ 2 ] ) );
    
end );

##
InstallMethod( SetLowerBound,
               "for lazy integers",
               [ IsLazyIntegerRep, IsInt ],
               
  function( x, bound )
    local intervall_list, i, did_anything_happen, old_bound, remove_list;
    
    did_anything_happen := false;
    
    old_bound := CurrentLowerBound( x );
    
    intervall_list := x!.intervalls;
    
    remove_list := [ ];
    
    for i in intervall_list do
        
        if i[ 1 ] < bound then
            
            if i[ 2 ] < bound then
                
                Add( remove_list, i );
                
            else
                
                i[ 1 ] := bound;
                
            fi;
            
            did_anything_happen := true;
            
        fi;
        
    od;
    
    for i in remove_list do
        
        Remove( intervall_list, Position( intervall_list, i ) );
        
    od;
    
    if intervall_list = [ ] then
        
        Error( "integer has been invalidated!" );
        
    fi;
    
    if Length( intervall_list ) = 1 and intervall_list[ 1 ][ 1 ] = intervall_list[ 1 ][ 2 ] then
        
        SetFilterObj( x, IsCrisp );
        
        SetCrispValue( x, intervall_list[ 1 ][ 1 ] );
        
    fi;
    
    
    if did_anything_happen then
        
        LazyIntegers_Update_Lower_Bound( x, bound, old_bound );
        
    fi;
    
end );

##
InstallMethod( SetUpperBound,
               "for lazy integers",
               [ IsLazyIntegerRep, IsInt ],
               
  function( x, bound )
    local intervall_list, i, did_anything_happen, old_bound, remove_list;
    
    did_anything_happen := false;
    
    old_bound := CurrentUpperBound( x );
    
    intervall_list := x!.intervalls;
    
    remove_list := [ ];
    
    for i in intervall_list do
        
        if i[ 2 ] > bound then
            
            if i[ 1 ] > bound then
                
                Add( remove_list, i );
                
            else
                
                i[ 2 ] := bound;
                
            fi;
            
            did_anything_happen := true;
            
        fi;
        
    od;
    
    for i in remove_list do
        
        Remove( intervall_list, Position( intervall_list, i ) );
        
    od;
    
    if intervall_list = [ ] then
        
        Error( "integer has been invalidated!" );
        
    fi;
    
    if Length( intervall_list ) = 1 and intervall_list[ 1 ][ 1 ] = intervall_list[ 1 ][ 2 ] then
        
        SetFilterObj( x, IsCrisp );
        
        SetCrispValue( x, intervall_list[ 1 ][ 1 ] );
        
    fi;
    
    
    if did_anything_happen then
        
        LazyIntegers_Update_Upper_Bound( x, bound, old_bound );
        
    fi;
    
end );

##
InstallMethod( SetBounds,
               "for lazy integers",
               [ IsLazyInteger, IsList ],
               
  function( x, bounds )
    
    if ( not Length( bounds ) = 2 ) or ( not ForAll( bounds, IsInt ) ) then
        
        Error( "second argument must be a list with two integers" );
        
    fi;
    
    SetLowerBound( x, bounds[ 1 ] );
    
    SetUpperBound( x, bounds[ 2 ] );
    
end );

##
InstallMethod( SetNotEqualTo,
               "for lazy integers and int",
               [ IsLazyInteger, IsInt ],
               
  function( lazy_int, not_equal )
    local intervall, i, did_anything_happen, remove_list, new_intervalls, new_intervall;
    
    did_anything_happen := false;
    
    intervall := lazy_int!.intervalls;
    
    remove_list := [ ];
    
    new_intervalls := [ ];
    
    for i in [ 1 .. Length( intervall ) ] do
        
        if intervall[ i ][ 1 ] <= not_equal and intervall[ i ][ 2 ] >= not_equal then
            
            did_anything_happen := true;
            
            Add( remove_list, intervall[ i ] );
            
            new_intervall := [ intervall[ i ][ 1 ], not_equal - 1 ];
            
            if new_intervall[ 1 ] <= new_intervall[ 2 ] then
                
                Add( new_intervalls, new_intervall );
                
            fi;
            
            new_intervall := [ not_equal + 1, intervall[ i ][ 2 ] ];
            
            if new_intervall[ 1 ] <= new_intervall[ 2 ] then
                
                Add( new_intervalls, new_intervall );
                
            fi;
            
        fi;
        
    od;
    
    for i in remove_list do
        
        Remove( intervall, Position( intervall, i ) );
        
    od;
    
    for i in new_intervalls do
        
        Add( intervall, i );
        
    od;
    
    if Length( intervall ) = 1 and intervall[ 1 ][ 1 ] = intervall[ 1 ][ 2 ] then
        
        SetFilterObj( lazy_int, IsCrisp );
        
        SetCrispValue( lazy_int, intervall[ 1 ][ 1 ] );
        
    fi;
    
    if did_anything_happen then
        
        LazyIntegers_Update_Not_Equal( lazy_int, not_equal );
        
    fi;
    
end );

#########################
##
## Tool functions
##
#########################

InstallMethod( \+,
               "for lazy integers",
               [ IsLazyInteger, IsLazyInteger ],
               
  function( int1, int2 )
    local intervalls1, intervalls2, new_intervalls, new_integer, summands1, summands2;
    
    intervalls1 := int1!.intervalls;
    
    intervalls2 := int2!.intervalls;
    
    new_intervalls := Concatenation( List( intervalls1, i -> List( intervalls2, j -> LazyIntegers_Intervall_Plus( i, j ) ) ) );
    
    new_intervalls := LazyIntegers_Intervall_List_To_Disjoint_Union( new_intervalls );
    
    new_integer := LazyInteger( new_intervalls );
    
    new_integer!.summands := [ int1, int2 ];
    
    Add( int1!.is_summand_of, new_integer );
    
    Add( int2!.is_summand_of, new_integer );
    
    return new_integer;
    
end );

InstallMethod( \+,
               "lazy integer and int",
               [ IsLazyInteger, IsInt ],
               
  function( lazy_int, int )
    local new_intervalls, new_lazy_int;
    
    new_intervalls := lazy_int!.intervalls;
    
    new_intervalls := new_intervalls + int;
    
    new_lazy_int := LazyInteger( new_intervalls );
    
    Add( lazy_int!.sum_with_int, [ new_lazy_int, int ] );
    
    Add( new_lazy_int!.sum_with_int, [ lazy_int, - int ] );
    
    return new_lazy_int;
    
end );

InstallMethod( \+,
               [ IsInt, IsLazyInteger ],
               
  function( int, lazy_int )
    
    return lazy_int + int;
    
end );



InstallMethod( \*,
               "for lazy integers",
               [ IsLazyInteger, IsLazyInteger ],
               
  function( int1, int2 )
    local intervalls1, intervalls2, new_intervalls, new_integer, summands1, summands2;
    
    intervalls1 := int1!.intervalls;
    
    intervalls2 := int2!.intervalls;
    
    new_intervalls := Concatenation( List( intervalls1, i -> List( intervalls2, j -> LazyIntegers_Intervall_Mult( i, j ) ) ) );
    
    new_intervalls := LazyIntegers_Intervall_List_To_Disjoint_Union( new_intervalls );
    
    new_integer := LazyInteger( new_intervalls );
    
    new_integer!.factors := [ int1, int2 ];
    
    Add( int1!.is_factor_of, new_integer );
    
    Add( int2!.is_factor_of, new_integer );
    
    return new_integer;
    
end );

InstallMethod( SetEqual,
               "for lazy integers",
               [ IsLazyInteger, IsLazyInteger ],
               
  function( int1, int2 )
    local new_intervalls, i, j, new_intervall, start_point_list, end_point_list, start_point, end_point;
    
    new_intervalls := [ ];
    
    for i in int1!.intervalls do
        
        for j in int2!.intervalls do
            
            new_intervall := [ Maximum( i[ 1 ], j[ 1 ] ), Minimum( i[ 2 ], j[ 2 ] ) ];
            
            if new_intervall[ 1 ] <= new_intervall[ 2 ] then
                
                Add( new_intervalls, new_intervall );
                
            fi;
            
        od;
        
    od;
    
    if new_intervalls = [ [ LazyIntegers_Minus_Infinity, LazyIntegers_Infinity ] ] then
        
        Add( int1!.equals, int2 );
        
        Add( int2!.equals, int1 );
        
        return;
        
    fi;
    
    start_point_list := Concatenation( List( int1!.intervalls, i -> i[ 1 ] ), List( int2!.intervalls, i -> i[ 1 ] ) );
    
    end_point_list := Concatenation( List( int1!.intervalls, i -> i[ 2 ] ), List( int2!.intervalls, i -> i[ 2 ] ) );
    
#     if CurrentLowerBound( int1 ) = LazyIntegers_Minus_Infinity and CurrentLowerBound( int2 ) = Lazy
    
    for i in [ start_point .. end_point ] do
        
        if not ForAny( new_intervalls, i -> i[ 1 ] <= i and i[ 2 ] >= i ) then
            
            SetNotEqualTo( int1, i );
            
            SetNotEqualTo( int2, i );
            
        fi;
        
    od;
    
    Add( int1!.equals, int2 );
    
    Add( int2!.equals, int1 );
    
end );

#########################
##
## Tool functions
##
#########################

## Maybe check if first entry is larger than second

# ##
# InstallGlobalFunction( LazyIntegers_Intervall_Intersect,
#                        
#    function( intervall1, intervall2 )
#     
#     ## No checks are done for speed up.
#     ## Please take care of proper input.
   
   

##
InstallGlobalFunction( LazyIntegers_Intervall_Plus,
                       
  function( intervall1, intervall2 )
    
    if not IsList( intervall1 ) or not Length( intervall1 ) = 2 then
        
        Error( "first argument is not an intervall" );
        
    fi;
    
    if not IsList( intervall2 ) or not Length( intervall2 ) = 2 then
        
        Error( "second argument is not an intervall" );
        
    fi;
    
    return [ intervall1[ 1 ] + intervall2[ 1 ], intervall1[ 2 ] + intervall2[ 2 ] ];
    
end );

##
InstallGlobalFunction( LazyIntegers_Intervall_Minus,
                       
  function( intervall1, intervall2 )
    
    if not IsList( intervall1 ) or not Length( intervall1 ) = 2 then
        
        Error( "first argument is not an intervall" );
        
    fi;
    
    if not IsList( intervall2 ) or not Length( intervall2 ) = 2 then
        
        Error( "second argument is not an intervall" );
        
    fi;
    
    return [ intervall1[ 1 ] - intervall2[ 2 ], intervall1[ 2 ] - intervall2[ 1 ] ];
    
end );

##
InstallGlobalFunction( LazyIntegers_Intervall_Mult,
                       
  function( intervall1, intervall2 )
    local products;
    
    if not IsList( intervall1 ) or not Length( intervall1 ) = 2 then
        
        Error( "first argument is not an intervall" );
        
    fi;
    
    if not IsList( intervall2 ) or not Length( intervall2 ) = 2 then
        
        Error( "second argument is not an intervall" );
        
    fi;
    
    products := Concatenation( List( intervall1, i -> List( intervall2, j -> i * j ) ) );
    
    return [ Minimum( products ), Maximum( products ) ];
    
end );

##
InstallGlobalFunction( LazyIntegers_Intervall_Additive_Inverse,
                       
  function( intervall )
    
    if not IsList( intervall ) or not Length( intervall ) = 2 then
        
        Error( "first argument is not an intervall" );
        
    fi;
    
    return [ - intervall[ 2 ], - intervall[ 1 ] ];
    
end );

##
InstallGlobalFunction( LazyIntegers_Intervall_List_To_Disjoint_Union,
                       
  function( list )
    local new_list, intervall, i, intervall_from_list, intervall1, intervall2;
    
    new_list := [ ];
    
    while Length( list ) > 0 do
        
        intervall := Remove( list, 1 );
        
        i := 1;
        
        while i < Length( list ) do
            
            intervall_from_list := list[ i ];
            
            if intervall_from_list[ 1 ] < intervall[ 1 ] then
                
                intervall1 := intervall_from_list;
                
                intervall2 := intervall;
                
            else
                
                intervall1 := intervall;
                
                intervall2 := intervall_from_list;
                
            fi;
            
            if intervall1[ 2 ] > intervall2[ 1 ] then
                
                intervall := [ intervall1[ 1 ], Maximum( intervall1[ 2 ], intervall2[ 2 ] ) ];
                
                Remove( list, i );
                
                i := 1;
                
            else
                
                i := i + 1;
                
            fi;
            
        od;
        
        Add( new_list, intervall );
        
    od;
    
    return new_list;
    
end );

########################
##
## Display & View
##
########################

##
InstallMethod( ViewObj,
               "for inf",
               [ IsLazyIntegersInfinityRep ],
               
  function( x )
    
    Print( "<infinity>" );
    
end );

##
InstallMethod( PrintObj,
               "for inf",
               [ IsLazyIntegersInfinityRep ],
               
  function( x )
    
    Print( "infinity" );
    
end );

##
InstallMethod( String,
               "for inf",
               [ IsLazyIntegersInfinityRep ],
               
  function( x )
    
    return "infinity";
    
end );

##
InstallMethod( Display,
               "for inf",
               [ IsLazyIntegersInfinityRep ],
               
  function( x )
    
    Print( "infinity.\n" );
    
end );

##
InstallMethod( ViewObj,
               "for minus inf",
               [ IsLazyIntegersMinusInfinityRep ],
               
  function( x )
    
    Print( "<minus infinity>" );
    
end );

##
InstallMethod( PrintObj,
               "for minus inf",
               [ IsLazyIntegersMinusInfinityRep ],
               
  function( x )
    
    Print( "minus infinity" );
    
end );

##
InstallMethod( String,
               "for minus inf",
               [ IsLazyIntegersMinusInfinityRep ],
               
  function( x )
    
    return "minus infinity";
    
end );

##
InstallMethod( Display,
               "for minus inf",
               [ IsLazyIntegersMinusInfinityRep ],
               
  function( x )
    
    Print( "minus infinity.\n" );
    
end );

##
InstallMethod( ViewObj,
               "for crisp values",
               [ IsLazyInteger and HasCrispValue ],
               
  function( x )
    
    Print( Concatenation( String( CrispValue( x ) ) ) );
    
end );

##
InstallMethod( Display,
               "for crisp values",
               [ IsLazyInteger and HasCrispValue ],
               
  function( x )
    
    Print( Concatenation( String( CrispValue( x ) ) ) );
    
end );

##
InstallMethod( ViewObj,
               "for lazy integers",
               [ IsLazyInteger ],
               
  function( x )
    
    Print( Concatenation( "<A lazy integer currently between ", String( CurrentLowerBound( x ) ), " and ", String( CurrentUpperBound( x ) ), ">" ) );
    
end );

