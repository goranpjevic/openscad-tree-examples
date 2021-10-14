//// random apple trees

/// module random_apple_tree:
/// 	make a random apple tree.
///
/// 	parameters:
/// 		size: size of the tree
/// 		n: number of branch levels
module random_apple_tree(size, n, first=true) {

	// roots
	if (first) {
		roots(size);
	}

	if (n > 0) {

		// trunk
		scale_width = rands(8,12,1)[0];
		bottom_width = size/scale_width;
		top_width = size/(scale_width+2);

		color("sienna")
			cylinder(r1=bottom_width, r2=top_width, h=size, $fn=24);

		// branches
		translate([0,0,size]) {
			// make 4 branches on each level
			for(i=[0:3]) {

				// x rotation (inclination) of the branch
				x_rotation = rands(0,70,1)[0];
				// z rotation of the branch
				z_rotation = rands(-180,180,1)[0];
				// scale the size of the branch
				scale = rands(0.6,0.8,1)[0];

				rotate([x_rotation,0,z_rotation])
					random_apple_tree(scale*size, n-1, false);

			}
		}

	}
	else {

		// put leaves at the end of the branches
		leaves(size);

	}
}

/// module roots:
/// 	make roots.
///
/// 	parameters:
/// 		size: size of the roots.
module roots(size) {

	color("sienna")
		cylinder(r1=size/5, r2=0, h=size/7, $fn=5);

	// add apples on the ground
	ground_apples(size, 10);

}

/// module leaves:
/// 	make leaves.
///
/// 	parameters:
/// 		size: size of the leaves
module leaves(size) {

	color("green")
		sphere(r=size, $fn=50);

	// add apples
	apples(size, 3);

}

/// module apples:
/// 	make apples.
///
/// 	parameters:
/// 		size: radius of the spherical distribution of apples
/// 		num: number of apples to add
module apples(size, num) {

	// make num apples
	for (i=[1:num]) {

		// translate apples in all directions based on random factor
		min_max_factor = 0.8;
		x_translation = size*rands(-min_max_factor,min_max_factor,1)[0];
		y_translation = size*rands(-min_max_factor,min_max_factor,1)[0];
		z_translation = size*rands(-min_max_factor,min_max_factor,1)[0];

		color("red") translate([x_translation,y_translation,z_translation])
			sphere(r=1, $fn=24);

	}

}

/// module ground_apples:
/// 	make apples on the ground.
///
/// 	parameters:
/// 		distribution: area in which to put apples
/// 		num: number of apples to add
module ground_apples(distribution, num) {

	// make num apples
	for (i=[1:num]) {

		// translate based on the distribution
		x_translation = rands(-distribution,distribution,1)[0];
		y_translation = rands(-distribution,distribution,1)[0];

		color("red") translate([x_translation,y_translation,0])
			sphere(r=1, $fn=24);
	}
}


// make a random apple tree
random_apple_tree(50, 5);
