//// random coconut trees

/// module random_coconut_tree:
/// 	make random coconut tree.
///
/// 	parameters:
/// 		tree_size: size of the tree.
/// 		num_branch: number of branches.
/// 		num_coconuts: number of coconuts.
///		tree_color: color of the tree
///		add_coconuts_to_the_ground: will add coconuts on the ground
///		add_coconuts_to_the_leaves: will add coconuts on the leaves
///		min_random_leaf_rotation: minimum rotation angle for the leaves
///			in all directions
///		max_random_leaf_rotation: maximum rotation angle for the leaves
///			in all directions
///		branch_color: color of the branch
///		number_of_leaf_levels: number of leaf levels
///		leaf_color: color of the leaves
///		leaf_rotation: angle of rotation of the leaves
///		coconut_color: color of the coconuts
///		coconut_min_random_angle: random angle of the coconuts
///		coconut_max_random_angle: random angle of the coconuts
module random_coconut_tree(tree_size=40, num_branch=20, num_coconuts=10,
	tree_color="tan", add_coconuts_to_the_ground=true,
	add_coconuts_to_the_leaves=true, min_random_leaf_rotation=0,
	max_random_leaf_rotation=360, branch_color="green",
	number_of_leaf_levels=15, leaf_color="green", leaf_rotation=30,
	coconut_color="saddlebrown", coconut_min_random_angle=0,
	coconut_max_random_angle=360) {

	// trunk
	color(tree_color) cylinder(r1=tree_size/90, r2=tree_size/100, h=tree_size, $fn=24);

	// add branches and coconuts at the top of the trunk
	translate([0,0,tree_size]) {

		// branches
		for (i=[0:num_branch]) {
			angles = rands(min_random_leaf_rotation,max_random_leaf_rotation,3);
			rotate([angles[0],angles[1],angles[2]]) {
				branch(tree_size, branch_color, number_of_leaf_levels, leaf_color, leaf_rotation);
			}
		}

		// coconuts
		if (add_coconuts_to_the_leaves) {
			for(i=[0:num_coconuts]) {
				coconuts(tree_size, coconut_color, coconut_min_random_angle, coconut_max_random_angle);
			}
		}

	}

	// add coconuts on the ground
	if (add_coconuts_to_the_ground) {
		ground_coconuts(tree_size, num_coconuts/10, coconut_color);
	}
}

/// module branch:
/// 	make branch.
///
/// 	parameters:
/// 		branch_size: size of the tree.
///		branch_color: color of the branch
///		number_of_leaf_levels: number of leaf levels
///		leaf_color: color of the leaves
///		leaf_rotation: angle of rotation of the leaves
module branch(branch_size, branch_color, number_of_leaf_levels, leaf_color, leaf_rotation) {

	// make a branch
	color(branch_color) cylinder(r=branch_size/500, h=branch_size/3);

	//add surrounding leaves
	leaves(branch_size/3, number_of_leaf_levels, leaf_color, leaf_rotation);

}

/// module leaves:
/// 	make leaves around a branch.
///
/// 	parameters:
/// 		leaf_size: size of the branch.
///		number_of_leaf_levels: number of leaf levels
///		leaf_color: color of the leaves
///		leaf_rotation: angle of rotation of the leaves
module leaves(leaf_size, number_of_leaf_levels, leaf_color, leaf_rotation) {

	// add leaves on each level
	for (i=[1:number_of_leaf_levels]) {

		// add leaves on two sides
		color(leaf_color) translate([0,0,(leaf_size/number_of_leaf_levels)*i]) {

			rotate([leaf_rotation,0,0]) {
				cylinder(r=leaf_size/300, h=leaf_size/3);
			}

			rotate([-leaf_rotation,0,0]) {
				cylinder(r=leaf_size/300, h=leaf_size/3);
			}

		}

	}
}

/// module coconuts:
/// 	make coconuts at the top of the tree in a random distribution.
///
/// 	parameters:
/// 		coconut_size: size of the tree.
///		coconut_color: color of the coconuts
///		coconut_min_random_angle: random angle of the coconuts
///		coconut_max_random_angle: random angle of the coconuts
module coconuts(coconut_size, coconut_color, coconut_min_random_angle, coconut_max_random_angle) {

	// make random angles
	angles = rands(coconut_min_random_angle,coconut_max_random_angle,3);
	rotate([angles[0],angles[1],angles[2]]) {
		translate([0,0,coconut_size/20]) {
			color(coconut_color) sphere(coconut_size/30);
		}
	}

}

/// module ground_coconuts:
/// 	make coconuts on the ground in a random distribution.
///
/// 	parameters:
/// 		tree_size: size of the tree.
/// 		num: number of coconuts to add.
///		coconut_color: color of the coconuts
module ground_coconuts(tree_size, num, coconut_color) {

	coconut_size=tree_size/30;
	translate([0,0,coconut_size/2]) {
		for (i=[0:num]) {

			// make random x and y locations on the ground
			locations = rands(-tree_size/3,tree_size/3,2);
			translate([locations[0],locations[1],0]) {
				color(coconut_color) sphere(tree_size/30);
			}

		}
	}

}

// make a coconut tree
random_coconut_tree(40, 20, 10);
