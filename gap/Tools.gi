#############################################################################
##
##  Tools.gi                    homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementations of homalg tools.
##
#############################################################################

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( Eval,				### defines: an initial matrix full with zeros
        "for homalg matrices",
        [ IsHomalgMatrix and IsInitialMatrix ],
        
  function( C )
    local R, RP, z;
    
    R := HomalgRing( C );
    
    RP := HomalgTable( R );
    
    if IsHomalgExternalMatrixRep( C ) then
        if IsBound( RP!.ZeroMatrix ) then
            ResetFilterObj( C, IsInitialMatrix );
            return RP!.ZeroMatrix( C );
        else
            Error( "could not find a procedure called ZeroMatrix to evaluate an external zero matrix in the HomalgTable", RP, "\n" );
        fi;
    fi;
    
    z := Zero( HomalgRing( C ) );
    
    #=====# begin of the core procedure #=====#
    
    ResetFilterObj( C, IsInitialMatrix );
    
    return ListWithIdenticalEntries( NrRows( C ),  ListWithIdenticalEntries( NrColumns( C ), z ) );
    
end );

##
InstallMethod( Eval,				### defines: ZeroMap
        "for homalg matrices",
        [ IsHomalgMatrix and IsZeroMatrix ],
        
  function( C )
    local R, RP, z;
    
    R := HomalgRing( C );
    
    RP := HomalgTable( R );
    
    if IsHomalgExternalMatrixRep( C ) then
        if IsBound( RP!.ZeroMatrix ) then
            return RP!.ZeroMatrix( C );
        else
            Error( "could not find a procedure called ZeroMatrix to evaluate an external zero matrix in the HomalgTable", RP, "\n" );
        fi;
    fi;
    
    z := Zero( HomalgRing( C ) );
    
    #=====# begin of the core procedure #=====#
    
    return ListWithIdenticalEntries( NrRows( C ),  ListWithIdenticalEntries( NrColumns( C ), z ) );
    
end );

##
InstallMethod( Eval,				### defines: IdentityMap
        "for homalg matrices",
        [ IsHomalgMatrix and IsIdentityMatrix ],
        
  function( C )
    local R, RP, o, z, zz, id;
    
    R := HomalgRing( C );
    
    RP := HomalgTable( R );
    
    if IsHomalgExternalMatrixRep( C ) then
        if IsBound( RP!.IdentityMatrix ) then
            return RP!.IdentityMatrix( C );
        else
            Error( "could not find a procedure called IdentityMatrix to evaluate an external identity matrix in the HomalgTable", RP, "\n" );
        fi;
    fi;
    
    z := Zero( HomalgRing( C ) );
    o := One( HomalgRing( C ) );
    
    #=====# begin of the core procedure #=====#
    
    zz := ListWithIdenticalEntries( NrColumns( C ), z );
    
    id := List( [ 1 .. NrRows( C ) ],
                function(i) local z; z := ShallowCopy( zz ); z[i] := o; return z; end );
    
    return id;
    
end );

##
InstallMethod( Eval,				### defines: Involution
        "for homalg matrices",
        [ IsHomalgMatrix and HasEvalInvolution ],
        
  function( C )
    local R, RP, M;
    
    R := HomalgRing( C );
    
    RP := HomalgTable( R );
    
    M :=  EvalInvolution( C );
    
    if IsBound(RP!.Involution) then
        return RP!.Involution( M );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    return TransposedMat( Eval( M ) );
    
end );

##
InstallMethod( Eval,				### defines: CertainRows
        "for homalg matrices",
        [ IsHomalgMatrix and HasEvalCertainRows ],
        
  function( C )
    local R, RP, e, M, plist;
    
    R := HomalgRing( C );
    
    RP := HomalgTable( R );
    
    e :=  EvalCertainRows( C );
    
    M := e[1];
    plist := e[2];
    
    if IsBound(RP!.CertainRows) then
        return RP!.CertainRows( M, plist );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    return Eval( M ){ plist };
    
end );

##
InstallMethod( Eval,				### defines: CertainColumns
        "for homalg matrices",
        [ IsHomalgMatrix and HasEvalCertainColumns ],
        
  function( C )
    local R, RP, e, M, plist;
    
    R := HomalgRing( C );
    
    RP := HomalgTable( R );
    
    e :=  EvalCertainColumns( C );
    
    M := e[1];
    plist := e[2];
    
    if IsBound(RP!.CertainColumns) then
        return RP!.CertainColumns( M, plist );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    return Eval( M ){ [ 1 .. NrRows( M ) ] }{plist};
    
end );

##
InstallMethod( Eval,				### defines: UnionOfRows
        "for homalg matrices",
        [ IsHomalgMatrix and HasEvalUnionOfRows ],
        
  function( C )
    local R, RP, e, A, B, U;
    
    R := HomalgRing( C );
    
    RP := HomalgTable( R );
    
    e :=  EvalUnionOfRows( C );
    
    A := e[1];
    B := e[2];
    
    if IsBound(RP!.UnionOfRows) then
        return RP!.UnionOfRows( A, B );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    U := ShallowCopy( Eval( A ) );
    
    U{ [ NrRows( A ) + 1 .. NrRows( A ) + NrRows( B ) ] } := Eval( B );
    
    return U;
    
end );

##
InstallMethod( Eval,				### defines: UnionOfColumns
        "for homalg matrices",
        [ IsHomalgMatrix and HasEvalUnionOfColumns ],
        
  function( C )
    local R, RP, e, A, B, U;
    
    R := HomalgRing( C );
    
    RP := HomalgTable( R );
    
    e :=  EvalUnionOfColumns( C );
    
    A := e[1];
    B := e[2];
    
    if IsBound(RP!.UnionOfColumns) then
        return RP!.UnionOfColumns( A, B );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    U := List( ShallowCopy( Eval( A ) ), ShallowCopy );
    
    U{ [ 1 .. NrRows( A ) ] }{ [ NrColumns( A ) + 1 .. NrColumns( A ) + NrColumns( B ) ] } := Eval( B );
    
    return U;
    
end );

##
InstallMethod( Eval,				### defines: DiagMat
        "for homalg matrices",
        [ IsHomalgMatrix and HasEvalDiagMat ],
        
  function( C )
    local R, RP, e, z, m, n, diag, mat;
    
    R := HomalgRing( C );
    
    RP := HomalgTable( R );
    
    e :=  EvalDiagMat( C );
    
    if IsBound(RP!.DiagMat) then
        return RP!.DiagMat( e );
    fi;
    
    z := Zero( HomalgRing( e[1] ) );
    
    m := Sum( List( e, NrRows ) );
    n := Sum( List( e, NrColumns ) );
    
    diag := List( [ 1 .. m ],  a -> List( [ 1 .. n ], b -> z ) );
    
    #=====# begin of the core procedure #=====#
    
    m := 0;
    n := 0;
    
    for mat in e do
        diag{ [ m + 1 .. m + NrRows( mat ) ] }{ [ n + 1 .. n + NrColumns( mat ) ] } := Eval( mat );
        m := m + NrRows( mat );
        n := n + NrColumns( mat );
    od;
    
    return diag;
    
end );

##
InstallMethod( Eval,				### defines: MulMat
        "for homalg matrices",
        [ IsHomalgMatrix and HasEvalMulMat ],
        
  function( C )
    local R, RP, e, a, A;
    
    R := HomalgRing( C );
    
    RP := HomalgTable( R );
    
    e :=  EvalMulMat( C );
    
    a := e[1];
    A := e[2];
    
    if IsBound(RP!.MulMat) then
        
        e := RP!.MulMat( a, A );
        
        if HasRingRelations( R ) then
            e := MatrixForHomalg( e, R );
            return Eval( DecideZero( e ) );
        fi;
        
        return e;
        
    fi;
    
    #=====# begin of the core procedure #=====#
    
    e := a * Eval( A );
    
    if HasRingRelations( R ) then
        e := MatrixForHomalg( e, R );
        return Eval( DecideZero( e ) );
    fi;
    
    return e;
    
end );

##
InstallMethod( Eval,				### defines: AddMat
        "for homalg matrices",
        [ IsHomalgMatrix and HasEvalAddMat ],
        
  function( C )
    local R, RP, e, A, B;
    
    R := HomalgRing( C );
    
    RP := HomalgTable( R );
    
    e :=  EvalAddMat( C );
    
    A := e[1];
    B := e[2];
    
    if IsBound(RP!.AddMat) then
        
        e := RP!.AddMat( A, B );
        
        if HasRingRelations( R ) then
            e := MatrixForHomalg( e, R );
            return Eval( DecideZero( e ) );
        fi;
        
        return e;
        
    fi;
    
    #=====# begin of the core procedure #=====#
    
    e := Eval( A ) + Eval( B );
    
    if HasRingRelations( R ) then
        e := MatrixForHomalg( e, R );
        return Eval( DecideZero( e ) );
    fi;
    
    return e;
    
end );

##
InstallMethod( Eval,				### defines: SubMat
        "for homalg matrices",
        [ IsHomalgMatrix and HasEvalSubMat ],
        
  function( C )
    local R, RP, e, A, B;
    
    R := HomalgRing( C );
    
    RP := HomalgTable( R );
    
    e :=  EvalSubMat( C );
    
    A := e[1];
    B := e[2];
    
    if IsBound(RP!.SubMat) then
        
        e := RP!.SubMat( A, B );
        
        if HasRingRelations( R ) then
            e := MatrixForHomalg( e, R );
            return Eval( DecideZero( e ) );
        fi;
        
        return e;
        
    fi;
    
    #=====# begin of the core procedure #=====#
    
    e := Eval( A ) - Eval( B );
    
    if HasRingRelations( R ) then
        e := MatrixForHomalg( e, R );
        return Eval( DecideZero( e ) );
    fi;
    
    return e;
    
end );

##
InstallMethod( Eval,				### defines: Compose
        "for homalg matrices",
        [ IsHomalgMatrix and HasEvalCompose ],
        
  function( C )
    local R, RP, e, A, B;
    
    R := HomalgRing( C );
    
    RP := HomalgTable( R );
    
    e :=  EvalCompose( C );
    
    A := e[1];
    B := e[2];
    
    if IsBound(RP!.Compose) then
        
        e := RP!.Compose( A, B );
        
        if HasRingRelations( R ) then
            e := MatrixForHomalg( e, R );
            return Eval( DecideZero( e ) );
        fi;
        
        return e;
        
    fi;
    
    #=====# begin of the core procedure #=====#
    
    e := Eval( A ) * Eval( B );
    
    if HasRingRelations( R ) then
        e := MatrixForHomalg( e, R );
        return Eval( DecideZero( e ) );
    fi;
    
    return e;
    
end );

##
InstallMethod( Eval,				### defines: AddRhs
        "for homalg matrices",
        [ IsHomalgMatrix and EvalAddRhs and HasPreEval ], ## don't remove HasPreEval
        
  function( C )
    local R, RP, A, B;
    
    R := HomalgRing( C );
    
    RP := HomalgTable( R );
    
    A := PreEval( C );
    B := RightHandSide( C );
    
    if IsBound(RP!.AddRhs) then
        return RP!.AddRhs( A, B );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    return Eval( A );
    
end );

##
InstallMethod( Eval,				### defines: AddBts
        "for homalg matrices",
        [ IsHomalgMatrix and EvalAddBts and HasPreEval ], ## don't remove HasPreEval
        
  function( C )
    local R, RP, A, B;
    
    R := HomalgRing( C );
    
    RP := HomalgTable( R );
    
    A := PreEval( C );
    B := BottomSide( C );
    
    if IsBound(RP!.AddBts) then
        return RP!.AddBts( A, B );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    return Eval( A );
    
end );

##
InstallMethod( Eval,				### defines: GetSide
        "for homalg matrices",
        [ IsHomalgMatrix and HasEvalGetSide ],
        
  function( C )
    local R, RP, e, side, A;
    
    R := HomalgRing( C );
    
    RP := HomalgTable( R );
    
    e :=  EvalGetSide( C );
    
    side := e[1];
    A := e[2];
    
    if IsBound(RP!.GetSide) then
        return RP!.GetSide( side, A );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    if side = "rhs" then
        return RightHandSide( A );
    elif side = "bts" then
        return BottomSide( A );
    elif side = "lhs" then
	return Eval( CertainColumns( A, [ 1 .. NrColumns( A ) ] ) ); ## this is in general not obsolete
    elif side = "ups" then
        return Eval( CertainRows( A, [ 1 .. NrRows( A ) ] ) ); ## this is in general not obsolete
    else
        Error( "the first argument must be either \"rhs\", \"bts\", \"lhs\", or \"ups\", but received: ", side, "\n" );
    fi;
    
end );

##
InstallMethod( Eval,
        "for homalg matrices",
        [ IsHomalgMatrix and HasPreEval ],
        
  function( C )
    local R, RP, e;
    
    R := HomalgRing( C );
    
    RP := HomalgTable( R );
    
    e :=  PreEval( C );
    
    if IsBound(RP!.PreEval) then
        return RP!.PreEval( e );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    return Eval( e );
    
end );

##
InstallMethod( NrRows,				### defines: NrRows
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( C )
    local R, RP;
    
    R := HomalgRing( C );
    
    RP := HomalgTable( R );
    
    if IsBound(RP!.NrRows) then
        return RP!.NrRows( C );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    return Length( Eval( C ) );
    
end );

##
InstallMethod( NrColumns,			### defines: NrColumns
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( C )
    local R, RP;
    
    R := HomalgRing( C );
    
    RP := HomalgTable( R );
    
    if IsBound(RP!.NrColumns) then
        return RP!.NrColumns( C );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    return Length( Eval( C )[ 1 ] );
    
end );

##
InstallMethod( ZeroRows,			### defines: ZeroRows
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( C )
    local R, RP, z;
    
    R := HomalgRing( C );
    
    RP := HomalgTable( R );
    
    if IsBound(RP!.ZeroRows) then
        return RP!.ZeroRows( C );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    z := MatrixForHomalg( "zero", 1, NrColumns( C ), R );
    
    return Filtered( [ 1 .. NrRows( C ) ], a -> CertainRows( C, [ a ] ) = z );
    
end );

##
InstallMethod( ZeroColumns,			### defines: ZeroColumns
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( C )
    local R, RP, z;
    
    R := HomalgRing( C );
    
    RP := HomalgTable( R );
    
    if IsBound(RP!.ZeroColumns) then
        return RP!.ZeroColumns( C );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    z := MatrixForHomalg( "zero", NrRows( C ), 1, R );
    
    return Filtered( [ 1 .. NrColumns( C ) ], a ->  CertainColumns( C, [ a ] ) = z );
    
end );
