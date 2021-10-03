# Read data and write it in C++ readable version to files

# Collect information
Read( "Data.txt" );
entries_per_line := 20;
number_lines := QuoInt( Length( data[1] ), entries_per_line );
dir := Directory( "/home/i/EvalHiggs/Data" );
name1 := "Fluxes.txt";
name2 := "H1.txt";
name3 := "H2.txt";
name4 := "H3.txt";

# Process fluxes
file := Filename( dir, name1 );
output := OutputTextFile( file, false );;
to_write := data[ 1 ];;
for i in [ 1 .. number_lines ] do
    line := List( [ 1 + ( i - 1 ) * entries_per_line .. entries_per_line + ( i - 1 ) * entries_per_line ], k -> String( to_write[ k ] ) );
    line := JoinStringsWithSeparator( line, "," );
    RemoveCharacters( line, " " );
    RemoveCharacters( line, "[" );
    line := ReplacedString( line, "'t',", "t]," );
    line := ReplacedString( line, "'t'", "t]," );
    if line[ Length( line ) ] <> ',' then
        line := Concatenation( line, "," );
    fi;
    WriteLine( output, line );
od;
line := List( [ entries_per_line * number_lines + 1 .. Length( to_write ) ], k -> String( to_write[ k ] ) );
line := JoinStringsWithSeparator( line, "," );
RemoveCharacters( line, " " );
RemoveCharacters( line, "[" );
line := ReplacedString( line, "'t',", "t]," );
line := ReplacedString( line, "'t'", "t]," );
if line[ Length( line ) ] <> ',' then
    line := Concatenation( line, "," );
fi;
WriteLine( output, line );
CloseStream(output);


# Process H1
file := Filename( dir, name2 );
to_write := data[ 2 ];;
output := OutputTextFile( file, false );;
for i in [ 1 .. number_lines ] do
    line := List( [ 1 + ( i - 1 ) * entries_per_line .. entries_per_line + ( i - 1 ) * entries_per_line ], k -> String( to_write[ k ] ) );
    line := JoinStringsWithSeparator( line, "," );
    RemoveCharacters( line, " " );
    RemoveCharacters( line, "[" );
    line := ReplacedString( line, "'t',", "t]," );
    line := ReplacedString( line, "'t'", "t]," );
    if line[ Length( line ) ] <> ',' then
        line := Concatenation( line, "," );
    fi;
    WriteLine( output, line );
od;
line := List( [ entries_per_line * number_lines + 1 .. Length( to_write ) ], k -> String( to_write[ k ] ) );
line := JoinStringsWithSeparator( line, "," );
RemoveCharacters( line, " " );
RemoveCharacters( line, "[" );
line := ReplacedString( line, "'t',", "t]," );
line := ReplacedString( line, "'t'", "t]," );
if line[ Length( line ) ] <> ',' then
    line := Concatenation( line, "," );
fi;
WriteLine( output, line );
CloseStream(output);


# Process H2
file := Filename( dir, name3 );
to_write := data[ 3 ];;
output := OutputTextFile( file, false );;
for i in [ 1 .. number_lines ] do
    line := List( [ 1 + ( i - 1 ) * entries_per_line .. entries_per_line + ( i - 1 ) * entries_per_line ], k -> String( to_write[ k ] ) );
    line := JoinStringsWithSeparator( line, "," );
    RemoveCharacters( line, " " );
    RemoveCharacters( line, "[" );
    line := ReplacedString( line, "'t',", "t]," );
    line := ReplacedString( line, "'t'", "t]," );
    if line[ Length( line ) ] <> ',' then
        line := Concatenation( line, "," );
    fi;
    WriteLine( output, line );
od;
line := List( [ entries_per_line * number_lines + 1 .. Length( to_write ) ], k -> String( to_write[ k ] ) );
line := JoinStringsWithSeparator( line, "," );
RemoveCharacters( line, " " );
RemoveCharacters( line, "[" );
line := ReplacedString( line, "'t',", "t]," );
line := ReplacedString( line, "'t'", "t]," );
if line[ Length( line ) ] <> ',' then
    line := Concatenation( line, "," );
fi;
WriteLine( output, line );
CloseStream(output);


# Process H3
file := Filename( dir, name4 );
to_write := data[ 4 ];;
output := OutputTextFile( file, false );;
for i in [ 1 .. number_lines ] do
    line := List( [ 1 + ( i - 1 ) * entries_per_line .. entries_per_line + ( i - 1 ) * entries_per_line ], k -> String( to_write[ k ] ) );
    line := JoinStringsWithSeparator( line, "," );
    RemoveCharacters( line, " " );
    RemoveCharacters( line, "[" );
    line := ReplacedString( line, "'t',", "t]," );
    line := ReplacedString( line, "'t'", "t]," );
    if line[ Length( line ) ] <> ',' then
        line := Concatenation( line, "," );
    fi;
    WriteLine( output, line );
od;
line := List( [ entries_per_line * number_lines + 1 .. Length( to_write ) ], k -> String( to_write[ k ] ) );
line := JoinStringsWithSeparator( line, "," );
RemoveCharacters( line, " " );
RemoveCharacters( line, "[" );
line := ReplacedString( line, "'t',", "t]," );
line := ReplacedString( line, "'t'", "t]," );
if line[ Length( line ) ] <> ',' then
    line := Concatenation( line, "," );
fi;
WriteLine( output, line );
CloseStream(output);
