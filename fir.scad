//// fir trees

/// module fir_tree:
/// 	make a fir tree.
///
/// 	parameters:
/// 		size: size of the tree.
module fir_tree(size) {
	color("burlywood") cylinder(r1=size/30, r2=size/50, h=size, $fn=24);

	roots(size);

	// add branches on num levels
	num = 15;
	for (i=[1:num]) {

		translate([0,0,(size/num)*i]) {
			branches(size, i);
		}
	}
}

/// module branches:
/// 	make branches for the fir tree.
///
/// 	parameters:
/// 		size: size of the branches.
/// 		level: level of the branches.
module branches(size, level) {

	// number of branches on level
	num = 15;
	for (i=[0:num]) {
		rotate([100,0,i*(360/num)]) {

			length_of_branch = (size/3)-(level*(size/50));
			color("burlywood") cylinder(r=size/200, h=length_of_branch, $fn=24);

			// add needles
			needles(size, level, length_of_branch);

			// add cones
			// number of cones to add
			number_of_cones = rands(1,num/level,1)[0];
			cones(number_of_cones, length_of_branch, size);

		}
	}
}

/// module needles:
/// 	make needles.
///
/// 	parameters:
/// 		size: size of the needles.
/// 		level: level of the branch.
/// 		length_of_needles: length of the branch.
module needles(size, level, length_of_branch) {

	// number of levels of needles
	number_of_levels = 10;
	// number of needles on each level
	number_of_needles = 7;

	for (j=[0:number_of_levels]) {
		for (i=[0:number_of_needles]) {

			translate([0,0,(length_of_branch/number_of_levels)*j]) {
				rotate([80,0,i*(360/number_of_needles)]) {

					length_of_needles=13*size/450;
					color("green") cylinder(r=size/500, h=length_of_needles, $fn=24);

				}

			}

		}

	}
}

/// module roots:
/// 	make roots.
///
/// 	parameters:
/// 		size: size of the roots.
module roots(size) {

	color("burlywood") cylinder(r1=size/13, r2=0, h=size/10, $fn=5);

}

/// module cones:
/// 	make cones.
///
/// 	parameters:
/// 		num: number of cones to make.
/// 		length_of_branch: length of the branch.
/// 		size: size of the tree.
module cones(num, length_of_branch, size) {

	for (i=[1:num]) {

		translate([0,0,(length_of_branch/num)*i]) {
			rotate([50,0,0]) {
				color("brown") cylinder(r=size/300, h=size/70, $fn=20);
			}
		}

	}

}

fir_tree(50);
