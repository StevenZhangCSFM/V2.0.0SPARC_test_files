originalFracCoords = [0 0 0.6
    0 0.33333 0.6
    0.5 0.5 0.6
    0.5 0.86666 0.6
    0.5 0.16666 0.4
    0.5 0.5 0.4
    1 0.66666 0.4
    1 1 0.4];
timeToExpand = [8 4 1];
newFracCoords = expandFracCoord(originalFracCoords, timeToExpand);
scatter3(newFracCoords(:, 1), newFracCoords(:, 2), newFracCoords(:, 3));

function newFracCoords = expandFracCoord(originalFracCoords, timeToExpand)
    atomNumber = size(originalFracCoords, 1);
    repeatTime = prod(timeToExpand);
    originalAtomsInLargeCell = originalFracCoords ./ timeToExpand;
    latticeX = (0:(timeToExpand(1) - 1)) / timeToExpand(1);
    latticeY = (0:(timeToExpand(2) - 1)) / timeToExpand(2);
    latticeZ = (0:(timeToExpand(3) - 1)) / timeToExpand(3);
    [timeX, timeY, timeZ] = meshgrid(latticeX, latticeY, latticeZ);
    for i = 1:timeToExpand(3) % transpose X, Y
        permute(timeX,[2 1 3]);
        permute(timeY,[2 1 3]);
        permute(timeZ,[2 1 3]);
    end
    latticeX1Ds = repmat((timeX(:))', atomNumber, 1);
    latticeY1Ds = repmat((timeY(:))', atomNumber, 1);
    latticeZ1Ds = repmat((timeZ(:))', atomNumber, 1);
    vecX1D = latticeX1Ds(:);
    vecY1D = latticeY1Ds(:);
    vecZ1D = latticeZ1Ds(:);
    atomsInLargeCell = repmat(originalAtomsInLargeCell, repeatTime, 1);
    newFracCoords = atomsInLargeCell + [vecX1D, vecY1D, vecZ1D];
end