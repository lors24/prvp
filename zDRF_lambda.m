function [z_lambda] = zDRF_lambda(n, m_bar,fi,w)

z_lambda = m_bar*w(1);

for i = 1:n
    z_lambda = z_lambda + fi(i)*w(i+1);
end

end

