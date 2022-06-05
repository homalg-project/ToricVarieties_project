#!/usr/bin/python3

# function to convert a string to a list of integers
def convert_string_to_list_of_ints( s ):
    s = s.replace( '[', '' )
    s = s.replace( ']', '' )
    s = s.split( ',' )
    return [ int( x ) for x in s ]

# read in data
import sys
data = sys.argv[ 1 ].split( " " )
genus_list = convert_string_to_list_of_ints( data[ 0 ] ) # genera
edge_list = data[ 1 ].replace( '[[', '[' ).replace( ']]', ']' ).split( '],' )
edge_list = [ convert_string_to_list_of_ints( x ) for x in edge_list ]
C_i_name = [ str( i ) for i in data[ 2 ].replace( '[', '' ).replace( ']', '' ).split( ',' ) ]

# create colour scheme
C_i_genus_color=[]
for i in range(len(genus_list)):
    if genus_list[i]<0:
        C_i_genus_color.append("c")
    if genus_list[i]==0:
        C_i_genus_color.append("p")
    if genus_list[i]==1:
        C_i_genus_color.append("g")
    if genus_list[i]>1:
        C_i_genus_color.append("r")

# try to proceed
try:
    
    #import igraph
    from igraph import *
    
    # prepare for printing
    g=Graph(edge_list)
    g.vs["name"] = C_i_name
    g.vs["genus"] = C_i_genus_color
    color_dict = {"c": "cyan", "g": "green","r": "red", "p": "pink"}
    g.vs["color"] = [color_dict[genus] for genus in g.vs["genus"]]
    layout = g.layout_kamada_kawai()
    g.vs["label"] = g.vs["name"]
    
    # issue the printing
    plot(g, layout = layout)
    
except ModuleNotFoundError as err:
    print( "Could not print the graph. Python module igraph used for the plot, but was not found." )
    print( "You can try to run: pip3 install cairocffi. This could potentially fix the issue." )
    print( err )
