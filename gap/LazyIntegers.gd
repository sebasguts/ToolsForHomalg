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

DeclareGlobalFunction( "LazyIntegers_Intervall_List_To_Disjoint_Union" );

DeclareGlobalFunction( "LazyIntegers_Intervall_Intersect" );

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

DeclareOperation( "SetEqual",
                  [ IsLazyInteger, IsLazyInteger ] );

#######################
##
## Setters for bounds
##
#######################

DeclareFilter( "IsCrisp",
               IsLazyInteger );

DeclareAttribute( "CrispValue",
                  IsLazyInteger );

DeclareOperation( "SetLowerBound",
                  [ IsLazyInteger, IsInt ] );

DeclareOperation( "SetUpperBound",
                  [ IsLazyInteger, IsInt ] );

DeclareOperation( "SetBounds",
                  [ IsLazyInteger, IsList ] );

DeclareOperation( "SetNotEqualTo",
                  [ IsLazyInteger, IsInt ] );

#######################
##
## Arithmetics
##
#######################

DeclareGlobalFunction( "LazyIntegers_Update_Lower_Bound" );

DeclareGlobalFunction( "LazyIntegers_Update_Upper_Bound" );

DeclareGlobalFunction( "LazyIntegers_Update_Not_Equal" );

#######################
##
## Arithmetics
##
#######################

DeclareOperation( "\+",
                  [ IsLazyInteger, IsLazyInteger ] );

DeclareOperation( "\*",
                  [ IsLazyInteger, IsLazyInteger ] );

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
