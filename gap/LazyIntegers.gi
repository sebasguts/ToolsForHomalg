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
