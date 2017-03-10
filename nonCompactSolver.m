function[transfer, sol, bvpsol] = nonCompactSolver(splines, N, omega, suppress)
	phi0 = [1; 0; 0; 0; 0];%p w theta s Y
	bcs = zeros(5,1);
	disp('here');
	N
	disp('past here');
	sol = bvpinit(linspace(0, 1, N), [0.5 0.5 0.5 0.5 0.5]);
	ODECaller = @(t, phi) nonCompactODE(t, phi, splines, omega);
	BCCaller = @(phi_a, phi_b) illPosedBCs(phi_a, phi_b, splines, bcs);
	bvpsol = bvp4c(ODECaller, BCCaller, sol);

	sol = nonCompactSolution(bvpsol, splines);


	if (suppress == false)
		plotSolution(sol);
	end


	transfer = sol.transfer;
end
