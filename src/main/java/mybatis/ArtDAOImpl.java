package mybatis;

import java.util.ArrayList;

import org.springframework.stereotype.Service;



@Service
public interface ArtDAOImpl {


	public int getTotalCount(ParameterDTO parameterDTO);
	public ArrayList<ArtsDTO> listPage(ParameterDTO parameterDTO);
	public ArtsDTO viewinfo(ParameterDTO parameterDTO);	
	public String eduinfo(ParameterDTO parameterDTO);
	public ArtsDTO getAuctionView(ParameterDTO parameterDTO);
	public ArrayList<ArtsDTO> recommList(ParameterDTO parameterDTO);	
	

	
	
	public int getTotalArtsCount(ParameterDTO parameterDTO);
	//작가소개 페이지
	//작가 인원수
	public int getTotalArtists(ArtistDTO artistDTO);
	//작가 명단
	public ArrayList<ArtistDTO> artistList(ArtistDTO artistDTO);
	public ArrayList<ArtsDTO> artistsWork(ParameterDTO parameterDTO);
	public MemberVO getArtistInfo(ParameterDTO parameterDTO);
	
}
