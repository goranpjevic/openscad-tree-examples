//// random apple trees

/// module random_apple_tree:
/// 	make a random apple tree.
///
/// 	parameters:
/// 		tree_size: size of the tree
/// 		branch_levels: number of branch levels
///		tree_color: color of the tree
///		roots: will the tree have roots
///		scale_width_min_random: minimum width of the tree
///		scale_width_max_random: maximum width of the tree
///		branches_per_level: number of branches on each level
///		min_x: minimum rotation in the x-axis
///		max_x: maximum rotation in the x-axis
///		min_y: minimum rotation in the y-ayis
///		max_y: maximum rotation in the y-ayis
///		scale_branch_min_random: minimum branch scaling factor for this level
///		scale_branch_max_random: maximum branch scaling factor for this level
///		add_apples_on_the_ground: will add apples to the ground
///		add_apples_on_the_leaves: will add apples to the leaves
///		number_of_apples_on_the_ground: number of apples to add on the
///			ground
///		number_of_apples_on_the_ground: number of apples to add on the
///			leaf
///		fruit_color: color of the fruit
///		leaf_color: color of the leaves
///		min_max_factor: range in which to add apples
module random_apple_tree(tree_size=50, branch_levels=5, first=true,
	tree_color="sienna", roots_bool=true, scale_width_min_random=8,
	scale_width_max_random=12, branches_per_level=4, min_x=0, max_x=70,
	min_y=-180, max_y=180, scale_branch_min_random=0.6, scale_branch_max_random=0.8,
	add_apples_on_the_ground=true, add_apples_on_the_leaves=true,
	number_of_apples_on_the_ground=10, number_of_apples_on_the_leaf=3,
	fruit_color="red", leaf_color="green", min_max_factor=0.8) {

	// roots
	if (roots_bool && first) {
		roots(tree_size, tree_color, add_apples_on_the_ground,
			number_of_apples_on_the_ground, fruit_color);
	}

	if (branch_levels > 0) {

		// trunk
		scale_width = rands(scale_width_min_random,scale_width_max_random,1)[0];
		bottom_width = tree_size/scale_width;
		top_width = tree_size/(scale_width+2);

		color(tree_color)
			cylinder(r1=bottom_width, r2=top_width, h=tree_size, $fn=24);

		// branches
		translate([0,0,tree_size]) {
			// make 'branches_per_level' branches on each level
			for(i=[0:branches_per_level-1]) {

				// x rotation (inclination) of the branch
				x_rotation = rands(min_x,max_x,1)[0];
				// z rotation of the branch
				z_rotation = rands(min_y,max_y,1)[0];
				// scale the size of the branch
				scale = rands(scale_branch_min_random,scale_branch_max_random,1)[0];

				rotate([x_rotation,0,z_rotation])
					random_apple_tree(scale*tree_size,
						branch_levels-1, false);

			}
		}

	}
	else {

		// put leaves at the end of the branches
		leaves(tree_size, leaf_color, fruit_color, add_apples_on_the_leaves, min_max_factor);

	}
}

/// module roots:
/// 	make roots.
///
/// 	parameters:
/// 		root_size: size of the roots.
///		root_color: color of the roots
///		add_apples_on_the_ground: will add apples to the ground
///		number_of_apples_on_the_ground: number of apples to add on the
///			ground
///		fruit_color: color of the fruit
module roots(root_size, root_color, add_apples_on_the_ground,
	number_of_apples_on_the_ground, fruit_color) {

	color(root_color)
		cylinder(r1=root_size/5, r2=0, h=root_size/7, $fn=5);

	if (add_apples_on_the_ground) {
		// add apples on the ground
		ground_apples(root_size, number_of_apples_on_the_ground, fruit_color);
	}

}

/// module leaves:
/// 	make leaves.
///
/// 	parameters:
/// 		leaf_size: size of the leaves
///		leaf_color: color of the leaves
///		fruit_color: color of the fruit
///		add_apples_on_the_leaves: will add apples to the leaves
///		min_max_factor: range in which to add apples
module leaves(leaf_size, leaf_color, fruit_color, add_apples_on_the_leaves, min_max_factor) {

	color(leaf_color)
		sphere(r=leaf_size, $fn=50);

	// add apples
	if (add_apples_on_the_leaves) {
		apples(leaf_size, 3, fruit_color, min_max_factor);
	}

}

/// module apples:
/// 	make apples.
///
/// 	parameters:
/// 		apple_distribution_size: radius of the spherical distribution
///			of apples
/// 		num: number of apples to add
///		fruit_color: color of the fruit
///		min_max_factor: random factor of position inside the
///			'apple_distribution_size', in the range
///			(-min_max_factor, +min_max_factor)
module apples(apple_distribution_size, num, fruit_color, min_max_factor) {

	// make num apples
	for (i=[1:num]) {

		// translate apples in all directions based on random factor
		x_translation = apple_distribution_size*rands(-min_max_factor,min_max_factor,1)[0];
		y_translation = apple_distribution_size*rands(-min_max_factor,min_max_factor,1)[0];
		z_translation = apple_distribution_size*rands(-min_max_factor,min_max_factor,1)[0];

		color(fruit_color) translate([x_translation,y_translation,z_translation])
			sphere(r=1, $fn=24);

	}

}

/// module ground_apples:
/// 	make apples on the ground.
///
/// 	parameters:
/// 		distribution: area in which to put apples
/// 		num: number of apples to add
///		fruit_color: color of the fruit
module ground_apples(distribution, num, fruit_color) {

	// make num apples
	for (i=[1:num]) {

		// translate based on the distribution
		x_translation = rands(-distribution,distribution,1)[0];
		y_translation = rands(-distribution,distribution,1)[0];

		color(fruit_color) translate([x_translation,y_translation,0])
			sphere(r=1, $fn=24);
	}
}


// make a random apple tree
random_apple_tree(50, 5);
