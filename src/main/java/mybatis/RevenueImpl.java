package mybatis;

import java.util.ArrayList;

import org.springframework.stereotype.Service;

@Service
public interface RevenueImpl {
	
	public int getTotalRevenueCount(ParameterDTO parameterDTO);
	public ArrayList<RevenueDTO> viewRevenueInfo(ParameterDTO parameterDTO); 
	
}
