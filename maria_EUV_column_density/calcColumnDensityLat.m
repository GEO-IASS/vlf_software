%makeGrid;
%fillGridDiff;
makePlot;

Lo = 3.85;
lamda_o = [ 0 10 20 ] .*pi/180;
%lamda_o = [ 10 ] .*pi/180;
llamda = linspace( -pi/2, pi/2 );

col = 'kbrkbrkbrkbr';
for( k = 1:length( lamda_o ) )

	[a_t, b_t] = dipoleTangent( Lo, lamda_o(k) );

	line_y = yy;
	line_x = ( line_y - b_t ) ./ a_t;

	for( m = 1:length( line_y ) )
		ii = nearest( xx, line_x( m ) );
		columnL(m) = L(m, ii);
		columnNi(m) = ni(m,ii);
	end;

	ii = find( columnL > 0 );
	columnL = columnL(ii);
	columnNi = columnNi(ii);
	columnNi = columnNi ./ max( columnNi );

	[ii, jj] = min( columnL );
	columnL = columnL - ii;
	columnL(1:jj) = -columnL(1:jj);

	[columnL, jj] = sort( columnL );	
	columnNi = columnNi(jj);

	axes( h_ax(1) );

	% PLOT TANGENT
	plot( line_x, line_y, [col(k) '-'] );

	% PLOT FIELD LINE 
    rr = Lo.*cos(llamda).^2;
    B_x = rr.*cos(llamda);
    B_z = rr.*sin(llamda);
    plot(B_x, B_z, [col(k) '-']);

	axes( h_ax(2) );
	plot( Lo*[1 1], ylim, [col(k) '-'] );
	axes( h_ax(3) );
	
	plot( columnL, columnNi, [col(k) '-'] );




end;
