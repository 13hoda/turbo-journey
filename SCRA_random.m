

function B_pa=SCRA_random(diff,dis,l,S,D,p_outage_max,Gama_th,Hops,p,Fad_gain,min_dis_node,n)

% fprintf('\nThe Transmitter is "%d" and The Receiver is "%d".\n\n',S,D);

if S==D
    error('The Transmitter and Receiver are The Same! Please Try Again')
    return 
end
kl=10^-7;
p_t=p;
 pr_th=10^-11;
p_noise=10^-16;
%n=[0,0;60,25;-22,22;21,-20;50,-0.2;120,-10;-20,-10;-10,22;10,5;90,-10;58,-12;100,0];
% %% Finding Euclidean distance between each node
% d=pdist(n,'euclidean');
% l=length(n)-1;
% d_len=length(d);
% di=zeros(1,l);
% dis = zeros(l);
% %% Making distance Matrix
% for k=1:l
%     for i=1:k-1
%         di(i)=dis(i,k-1);
%     end
% dis = triu(squareform(d));
% dis = dis(1:length(dis)-1,2:length(dis));
% 
% end
% for j=1:l
%     for i=1:l-1
%         if i+1<=j
%             continue
%         end
%         dis(i+1,j)=dis(j,i);
%     end
% end
% %%
m=[S];
%Finding First Path
 m=nexthops4(diff,S,D,m(1),p_t,pr_th,dis(S,:),m,kl,p,l,min_dis_node,dis,n);
% m=nexthops4(diff,S,p_t,pr_th,dis(S,:),m,kl,p);
j=3;
go=true;
B_path=S;
G_SNR_dB=0;
% while i<=length(m) && go
%     if m(i)==D
%                 
% 
%                 Path= MakePath2(m(i),m,length(m)-1,i,dis,l,kl,Gama_th,p);               
%                 B_path=Path;
%                 G_SNR_dB=SNR_dB_2(Path,p_noise,Fad_gain,p);
%                 go = false;
%                 
%     end
%     i=i+3;
% end
%  k=length(m)-1;    
%  m=[m,1000];
%  j=3;
%  tr=true;

 %%
      while m(j)~=D && go 

        %Finding the next hop which is in suitable distance
        if numel(m)>=4 && m(j)==l+1
           d=dis(:,m(j)-1);
           d=d';
        else 
           d=dis(m(j),:);
        end
        m=nexthops3(diff,S,D,m(j),m(j+1),pr_th,d,m,kl,p,l,min_dis_node,dis,n);

              if m(length(m)-1)==D
                Path= MakePath_n(m,dis,l,kl,Gama_th,p);
                SNR_dB=SNR_dB_2(Path,p_noise,Fad_gain,p); 
                go=false;
               
              end

        j=length(m)-1;
         
        
      end
 d_sr=dis_sr(dis,S,D,l);     
 num_hop=length(Path)-3;
 P_total=num_hop*p;
 p_out=Path(length(Path));
 B_pa=zeros(1,length(Path)-2);
 for i=1:length(Path)-2
    B_pa(i)=Path(i);
 end
 
 if length(Path)==1
    fprintf('Sorry We Could not found any Path to the Receiver "%d", Please Recheck Your Primitives and Try Again',D);
 else
% fprintf('\nP_outage is: %d\n Total distance is: %d\n Signal to Noise Ratio(dB) is: %d\n The number of Hops are: %d\nP_total is:%d\n The distance between Tr and Re is: %d \n G_SNR_db:%d\n length_m: %d.\n\n',B_path(length(B_path)),B_path(length(B_path)-1),snr_dB,num_hop,P_total,d_sr,G_SNR_dB,len_m);
 B_pa=[B_pa,p_out,SNR_dB,P_total,d_sr];
 end

%%
end  
