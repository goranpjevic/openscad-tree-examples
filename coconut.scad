//// random coconut trees

/// module random_coconut_tree:
/// 	make random coconut tree.
///
/// 	parameters:
/// 		size: size of the tree.
/// 		num_branch: number of branches.
/// 		num_coconuts: number of coconuts.
module random_coconut_tree(size, num_branch, num_coconuts) {

	// trunk
	color("tan") cylinder(r1=size/90, r2=size/100, h=size, $fn=24);

	// add branches and coconuts at the top of the trunk
	translate([0,0,size]) {

		// branches
		for (i=[0:num_branch]) {
			angles = rands(0,360,3);
			rotate([angles[0],angles[1],angles[2]]) {
				branch(size);
			}
		}

		// coconuts
		for(i=[0:num_coconuts]) {
			coconuts(size);
		}

	}

	// add coconuts on the ground
	ground_coconuts(size, num_coconuts/10);
}

/// module branch:
/// 	make branch.
///
/// 	parameters:
/// 		size: size of the tree.
module branch(size) {

	// make a branch
	color("green") cylinder(r=size/500, h=size/3);

	//add surrounding leaves
	leaves(size/3);

}

/// module leaves:
/// 	make leaves around a branch.
///
/// 	parameters:
/// 		size: size of the branch.
module leaves(size) {

	// number of leaf levels
	num = 15;
	for (i=[1:num]) {

		// add leaves on two sides
		color("green") translate([0,0,(size/num)*i]) {

			rotate([30,0,0]) {
				cylinder(r=size/300, h=size/3);
			}

			rotate([-30,0,0]) {
				cylinder(r=size/300, h=size/3);
			}

		}

	}
}

/// module coconuts:
/// 	make coconuts at the top of the tree in a random distribution.
///
/// 	parameters:
/// 		size: size of the tree.
module coconuts(size) {

	// make random angles
	angles = rands(0,360,3);
	rotate([angles[0],angles[1],angles[2]]) {
		translate([0,0,size/20]) {
			color("saddlebrown") sphere(size/30);
		}
	}

}

/// module ground_coconuts:
/// 	make coconuts on the ground in a random distribution.
///
/// 	parameters:
/// 		size: size of the tree.
/// 		num: number of coconuts to add.
module ground_coconuts(size, num) {

	coconut_size=size/30;
	translate([0,0,coconut_size/2]) {
		for (i=[0:num]) {

			// make random x and y locations on the ground
			locations = rands(-size/3,size/3,2);
			translate([locations[0],locations[1],0]) {
				color("saddlebrown") sphere(size/30);
			}

		}
	}

}

// make a coconut tree
random_coconut_tree(40, 20, 10);
