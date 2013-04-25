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
    
    integer := rec( intervalls := intervall_list );
    
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
## (minus) infinity
##
#########################

InstallValue( LazyIntegers_Minus_Infinity,
              rec() );

Objectify( TheTypeLazyIntegerMinusInfinity, LazyIntegers_Minus_Infinity );

InstallValue( LazyIntegers_Infinity,
              rec() );

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
    
    return Minimum( List( x!.intervalls, i -> i[ 2 ] ) );
    
end );

#########################
##
## Tool functions
##
#########################

## Maybe check if first entry is larger than second

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
    
    Print( "<infinity>\n" );
    
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
    
    Print( "<minus infinity>\n" );
    
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
    
    Print( Concatenation( String( CrispValue( x ) ), "\n" ) );
    
end );

##
InstallMethod( Display,
               "for crisp values",
               [ IsLazyInteger and HasCrispValue ],
               
  function( x )
    
    Print( Concatenation( String( CrispValue( x ) ), "\n" ) );
    
end );

##
InstallMethod( ViewObj,
               "for lazy integers"
               [ LazyInteger ],
               
  function( x )
    
    Print( Concatenation( "<A lazy integer currently between ", String( CurrentLowerBound( x ) ), " and ", String( CurrentUpperBound( x ) ), ">\n" ) );
    
end );

