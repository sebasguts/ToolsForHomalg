#############################################################################
##
##  LazyIntegers.gd                                 ToolsForHomalg package
##
##  Copyright 2007-2013, Mohamed Barakat, University of Kaiserslautern
##                       Sebastian Gutsche, RWTH-Aachen University
##                  Markus Lange-Hegermann, RWTH-Aachen University
##
##  The right integers for homalg.
##
#############################################################################

DeclareCategory( "IsLazyInteger",
                 IsObject );

DeclareGlobalFunction( "LazyIntegers_Intervall_Plus" );

DeclareGlobalFunction( "LazyIntegers_Intervall_Minus" );

DeclareGlobalFunction( "LazyIntegers_Intervall_Mult" );

DeclareGlobalFunction( "LazyIntegers_Intervall_Additive_Inverse" );

DeclareOperation( "\+",
                  [ IsInt, IsLazyInteger ] );

DeclareOperation( "\-",
                  [ IsInt, IsLazyInteger ] );

DeclareOperation( "\*",
                  [ IsInt, IsLazyInteger ] );

DeclareOperation( "\+",
                  [ IsLazyInteger, IsInt ] );

DeclareOperation( "\-",
                  [ IsLazyInteger, IsInt ] );

DeclareOperation( "\*",
                  [ IsLazyInteger, IsInt ] );

DeclareOperation( "CurrentLowerBound",
                  [ IsLazyInteger ] );

DeclareOperation( "CurrentUpperBound",
                  [ IsLazyInteger ] );

DeclareFilter( "IsCrisp",
               IsLazyInteger );

DeclareAttribute( "CrispValue",
                  IsLazyInteger );

#######################
##
## Constructors
##
#######################

DeclareGlobalFunction( "LazyIntegers_Main_Constructor" );

DeclareOperation( "LazyInteger",
                  [ ] );

DeclareOperation( "LazyIntegerWithLowerBound",
                  [ IsInt ] );

DeclareOperation( "LazyIntegerWithUpperBound",
                  [ IsInt ] );

DeclareOperation( "LazyInteger",
                  [ IsList ] );

#######################
##
## infinity
##
#######################

DeclareGlobalVariable( "LazyIntegers_Minus_Infinity" );

DeclareGlobalVariable( "LazyIntegers_Infinity" );
