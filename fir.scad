//// fir trees

/// module fir_tree:
/// 	make a fir tree.
///
/// 	parameters:
/// 		tree_size: size of the tree.
///		tree_color: color of the tree
///		add_roots: will add roots to the tree
///		number_of_branch_levels: number of branch levels of the tree
///		number_of_branches_on_level: number of branches to add on each level
///		branch_color: color of the branches
///		x_branch_rotation: rotation of the branch in the x-axis
///		y_branch_rotation: rotation of the branch in the y-axis
///		add_cones: will add cones to the branches
///		min_random_cones: minimum amount of cones to add to each branch
///		number_of_needle_levels: number of needle levels
///		number_of_needles_per_level: number of needles to add per each level
///		x_needle_rotation: needle rotation in the x-axis
///		y_needle_rotation: needle rotation in the y-axis
///		needle_color: color of the needles
///		root_color: color of the roots
///		x_cone_rotation: cone rotation in the x-axis
///		y_cone_rotation: cone rotation in the y-axis
///		z_cone_rotation: cone rotation in the z-axis
///		cone_color: color of the cones
module fir_tree(tree_size=50, tree_color="burlywood", add_roots=true,
	number_of_branch_levels=15, number_of_branches_on_level=15,
	branch_color="burlywood", x_branch_rotation=100, y_branch_rotation=0,
	add_cones=true, min_random_cones=1, number_of_needle_levels=10,
	number_of_needles_per_level=7, x_needle_rotation=80, y_needle_rotation=0,
	needle_color="green", root_color="burlywood", x_cone_rotation=50,
	y_cone_rotation=0, z_cone_rotation=0, cone_color="brown") {

	color(tree_color) cylinder(r1=tree_size/30, r2=tree_size/50, h=tree_size, $fn=24);

	// add roots
	if (add_roots) {
		roots(tree_size, root_color);
	}

	// add branches on 'number_of_branch_levels' levels
	for (i=[1:number_of_branch_levels]) {
		translate([0,0,(tree_size/number_of_branch_levels)*i]) {
			branches(tree_size, i, number_of_branches_on_level,
				branch_color, x_branch_rotation, y_branch_rotation, add_cones,
				min_random_cones, number_of_needle_levels,
				number_of_needles_per_level, x_needle_rotation, y_needle_rotation,
				needle_color, x_cone_rotation, y_cone_rotation,
				z_cone_rotation, cone_color);
		}
	}
}

/// module branches:
/// 	make branches for the fir tree.
///
/// 	parameters:
/// 		branch_size: size of the branches.
/// 		level: level of the branches.
///		number_of_branches_on_level: number of branches to add on each level
///		branch_color: color of the branches
///		x_branch_rotation: rotation of the branch in the x-axis
///		y_branch_rotation: rotation of the branch in the y-axis
///		add_cones: will add cones to the branches
///		min_random_cones: minimum amount of cones to add to each branch
///		number_of_needle_levels: number of needle levels
///		number_of_needles_per_level: number of needles to add per each level
///		x_needle_rotation: needle rotation in the x-axis
///		y_needle_rotation: needle rotation in the y-axis
///		needle_color: color of the needles
///		x_cone_rotation: cone rotation in the x-axis
///		y_cone_rotation: cone rotation in the y-axis
///		z_cone_rotation: cone rotation in the z-axis
///		cone_color: color of the cones
module branches(branch_size, level, number_of_branches_on_level, branch_color,
	x_branch_rotation, y_branch_rotation, add_cones, min_random_cones,
	number_of_needle_levels, number_of_needles_per_level, x_needle_rotation,
	y_needle_rotation, needle_color, x_cone_rotation, y_cone_rotation,
	z_cone_rotation, cone_color) {

	// number of branches on level
	for (i=[0:number_of_branches_on_level]) {
		rotate([x_branch_rotation,y_branch_rotation,i*(360/number_of_branches_on_level)]) {

			length_of_branch = (branch_size/3)-(level*(branch_size/50));
			color(branch_color) cylinder(r=branch_size/200, h=length_of_branch, $fn=24);

			// add needles
			needles(branch_size, level, length_of_branch,
				number_of_needle_levels, number_of_needles_per_level, x_needle_rotation,
				y_needle_rotation, needle_color);

			if (add_cones) {
				// add cones
				// number of cones to add
				number_of_cones = rands(min_random_cones,number_of_branches_on_level/level,1)[0];
				cones(number_of_cones, length_of_branch,
					branch_size, x_cone_rotation, y_cone_rotation, z_cone_rotation, cone_color);
			}

		}
	}
}

/// module needles:
/// 	make needles.
///
/// 	parameters:
/// 		needle_size: size of the needles.
/// 		level: level of the branch.
/// 		length_of_needles: length of the branch.
///		number_of_needle_levels: number of needle levels
///		number_of_needles_per_level: number of needles to add per each level
///		x_needle_rotation: needle rotation in the x-axis
///		y_needle_rotation: needle rotation in the y-axis
///		needle_color: color of the needles
module needles(needle_size, level, length_of_branch, number_of_needle_levels,
	number_of_needles_per_level, x_needle_rotation, y_needle_rotation,
	needle_color) {

	for (j=[0:number_of_needle_levels]) {
		for (i=[0:number_of_needles_per_level]) {

			translate([0,0,(length_of_branch/number_of_needle_levels)*j]) {
				rotate([x_needle_rotation,y_needle_rotation,i*(360/number_of_needles_per_level)]) {

					length_of_needles=13*needle_size/450;
					color(needle_color) cylinder(r=needle_size/500, h=length_of_needles, $fn=24);

				}

			}

		}

	}
}

/// module roots:
/// 	make roots.
///
/// 	parameters:
/// 		root_size: size of the roots.
///		root_color: color of the roots
module roots(root_size, root_color) {

	color(root_color) cylinder(r1=root_size/13, r2=0, h=root_size/10, $fn=5);

}

/// module cones:
/// 	make cones.
///
/// 	parameters:
/// 		num: number of cones to make.
/// 		length_of_branch: length of the branch.
/// 		cone_size: size of the cones.
///		x_cone_rotation: cone rotation in the x-axis
///		y_cone_rotation: cone rotation in the y-axis
///		z_cone_rotation: cone rotation in the z-axis
///		cone_color: color of the cones
module cones(num, length_of_branch, cone_size, x_cone_rotation, y_cone_rotation, z_cone_rotation, cone_color) {

	for (i=[1:num]) {

		translate([0,0,(length_of_branch/num)*i]) {
			rotate([x_cone_rotation,y_cone_rotation,z_cone_rotation]) {
				color(cone_color) cylinder(r=cone_size/300, h=cone_size/70, $fn=20);
			}
		}

	}

}

fir_tree(50);
