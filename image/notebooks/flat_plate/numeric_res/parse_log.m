function iters = parse_log(filename, N)

fid = fopen(filename, 'r');
if fid == -1
    error('Cannot open the file');
end

s = get_nextline(fid);
iters = zeros(N, 1);
for i=1:N
    s = get_nextline(fid);
    vals = scan_inversed(s);
    iters(i) = sscanf(vals, '%d');
end

fclose(fid);

% Get nextline and skip empty-lines and comments
function s = get_nextline(fid)

if ~feof(fid)
   s = fgetl(fid);
else
   s = '';
   return;
end
while ~feof(fid) && isempty(s)
    s = fgetl(fid);
end

%skip string of gaps
for i = 1 : length(s)
    if (s(i) ~= ' ')
        s = s(i:end);
        return
    end
end
s = get_nextline(fid);

% Scan from end for integers
function str_end = scan_inversed(str)

n = 0;
% loop from end
for i = length(str):-1:1
    if str(i) == '='
      n = i;
      break;
    end
end

str_end = str(n+1:end-1);