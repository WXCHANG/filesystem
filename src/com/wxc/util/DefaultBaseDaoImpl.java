package com.wxc.util;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;

/**
 * ���ݿ����    ����calss
* @ClassName: DefaultBaseDaoImpl 
* @Description: TODO(������һ�仰��������������) 
* @author fjn
* @date  
*
 */
public class DefaultBaseDaoImpl extends SqlSessionTemplate implements
        BatisBaseDao
{

    public DefaultBaseDaoImpl(SqlSessionFactory sqlSessionFactory) {
		super(sqlSessionFactory);	
	}

	private static final long serialVersionUID = -2493529163246756507L;

    /**
     * ��Ӷ���
     * 
     * @param sqlId IBatis SQL Id
     * @param obj ��Ҫ��ӵĶ���
     * 
     * @throws AKSQLException SQL�쳣
     */
    @Override
    public Integer add(String sqlId, Object obj) throws Exception
    {
    	
    	Integer result = 0;
        try
        {
        	result= super.insert(sqlId, obj);
        }
        catch (Exception sqle)
        {
            throw new Exception(sqle.getMessage(), sqle.getCause());
        }
        return result;
    }
    

    /**
     * ɾ������
     * 
     * @param sqlId IBatis SQL Id
     * @param params ɾ������
     * 
     * @throws AKSQLException SQL�쳣
     */
    @Override
    public Integer del(String sqlId, Object params) throws Exception
    {
    	Integer result = 0;
        
    	try
        {

    		result= super.delete(sqlId, params);
        }
        catch (Exception sqle)
        {
            throw new Exception(sqle.getMessage(), sqle.getCause());
        }
        return result;
    }

    /**
     * ��ѯ,����list
     * 
     * @param sqlId IBatis SQL Id
     * @param params ��ѯ����
     * 
     * @throws AKSQLException SQL�쳣
     * 
     * @return List<Object> ��ѯ�������
     */
    @Override
    public List<?> query(String sqlId, Object params) throws Exception
    {
        List<?> list = null;
        try
        {
        	list = super.selectList(sqlId, params);
        }
        catch (Exception sqle)
        {
            throw new Exception(sqle.getMessage(), sqle.getCause());
        }
        return list;
    }

    /**
     * ���¶���
     * 
     * @param sqlId IBatis SQL Id
     * @param updateObj ��Ҫ���µĶ���
     * 
     * @throws AKSQLException SQL�쳣
     */
    @Override
    public Integer upd(String sqlId, Object updateObj) throws Exception
    {
    	Integer result = null;
        try
        {
        	result=super.update(sqlId, updateObj);
        }
        catch (Exception sqle)
        {
            throw new Exception(sqle.getMessage(), sqle.getCause());
        }
        return result;
    }

    /**
     * ����������ѯ���ݼ�¼��,���ڷ�ҳ
     * 
     * @param sqlId IBatis SQL Id
     * @param params ��ѯ����
     * 
     * @throws AKSQLException SQL�쳣
     * 
     * @return List<Object> ��ѯ�������
     */
    @Override
    public int queryCount(String sqlId, Object params) throws Exception
    {
        int count = 0;
        try
        {
           count = super.selectOne(sqlId, params);
        }
        catch (NumberFormatException e)
        {
            count = 0;
        }
        catch (Exception e)
        {
            throw new Exception(e.getMessage(), e.getCause());
        }

        return count;
    }

    /**
     * ��ѯһ����¼
     * 
     * @param sqlId IBatis SQL Id
     * @param params ��ѯ����
     * 
     * @throws AKSQLException SQL�쳣
     * 
     * @return List<Object> ��ѯ�������
     */
    @Override
    public Object queryOneModel(String sqlId, Object params)
            throws Exception
    {
        try
        {
            return super.selectOne(sqlId, params);
        }
        catch (Exception e)
        {
            throw new Exception(e.getMessage(), e.getCause());
        }
    }

	@Override
	public int addReturn(String sqlId, Object obj) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int addGetId(String sqlId, Object obj) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public void beginTrans() throws SQLException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void endTrans() throws SQLException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void commitTrans() throws SQLException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void rollBack() throws SQLException {
		// TODO Auto-generated method stub
		
	}


	@Override
	public List<?> queryPagination(String sqlId, Object params)
			throws Exception {
		// TODO Auto-generated method stub
		return null;
	}


	@Override
	public List<?> queryAll(String sqlId) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

 

}
