
#include "KalmanFilter.h"

using namespace std;
using namespace Eigen;

template <typename t_matrix>
t_matrix PseudoInverse(const t_matrix& m, const double &tolerance=1.e-6)
{
  using namespace Eigen;
  typedef JacobiSVD<t_matrix> TSVD;
  unsigned int svd_opt(ComputeThinU | ComputeThinV);
  if(m.RowsAtCompileTime!=Dynamic || m.ColsAtCompileTime!=Dynamic)
  svd_opt= ComputeFullU | ComputeFullV;
  TSVD svd(m, svd_opt);
  const typename TSVD::SingularValuesType &sigma(svd.singularValues());
  typename TSVD::SingularValuesType sigma_inv(sigma.size());
  for(long i=0; i<sigma.size(); ++i)
  {
    if(sigma(i) > tolerance)
      sigma_inv(i)= 1.0/sigma(i);
    else
      sigma_inv(i)= 0.0;
  }
  return svd.matrixV()*sigma_inv.asDiagonal()*svd.matrixU().transpose();
}
kalmanfilter::kalmanfilter()
{
	I = MatrixXd::Identity(6, 6);
	x1.resize(6, 1);
	xO.resize(6, 1);

	double sigmaV2, sigmaW2;
	sigmaV2 = 500;//秒速0.8mくらいは加減速できる
	sigmaW2 = 20;//10センチくらいは計測誤差がある
	sigmaV = sigmaV2*sigmaV2;
	sigmaW = sigmaW2*sigmaW2;
	double sdVt = (double)(35.0 / 180.0) * 3.14;
	double sigmaVt = sdVt*sdVt;
	double sdWt = (double)(15.0 / 180.0) * 3.14;
	double sigmaWt = sdWt*sdWt;
	p1.resize(6, 6);

	y1.resize(3, 1);
	yb.resize(3, 1);

	A.resize(6, 6);
	R.resize(3, 3);
	Q.resize(3, 3);
	b.resize(6, 3);
	c.resize(3, 6);	
	cd.resize(3, 3);	
	
	RobotMat.resize(3, 1);
	Q << sigmaV, 0, 0,
		0, sigmaV, 0,
		0, 0, sigmaVt;
	R << sigmaW, 0, 0,
		0, sigmaW, 0,
		0, 0, sigmaWt;

	p1 << 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0;
}
kalmanfilter::~kalmanfilter() {}


wagon kalmanfilter::initialize(wagon observe, robot Robot, double nowtime)
{
	
	RobotMat << Robot.pos.x,
		Robot.pos.y,
		Robot.pos.z;
	
	c << cos(Robot.pos.z), 0,  sin(Robot.pos.z), 0, 0, 0,
		 -sin(Robot.pos.z), 0,  cos(Robot.pos.z), 0, 0, 0,
		0, 0, 0, 0, 1, 0;

	cd <<-cos(Robot.pos.z), -sin(Robot.pos.z), 0,
		 sin(Robot.pos.z),  -cos(Robot.pos.z), 0,
		0, 0, -1;

	y1 << observe.pos.x, observe.pos.y, observe.pos.z;
	x1 = PseudoInverse(c)*(y1-cd*RobotMat);
	xb=x1;
	before = observe;
	//cout<<"xb	"<<xb<<endl;
	time = nowtime;
	//cout<<"xb	"<<y1<<endl;
	before.pos.x = y1(0, 0);
	before.pos.y = y1(1, 0);
	before.pos.z = y1(2, 0);
	before.vel.x = 0;
	before.vel.y = 0;
	before.vel.z = 0;
	return before;
}
wagon kalmanfilter::globalInitialize(wagon observe,vector<double> pose, robot Robot, double nowtime)
{
	
	RobotMat << Robot.pos.x,
		Robot.pos.y,
		Robot.pos.z;
	
	c << cos(Robot.pos.z), 0,  sin(Robot.pos.z), 0, 0, 0,
		 -sin(Robot.pos.z), 0,  cos(Robot.pos.z), 0, 0, 0,
		0, 0, 0, 0, 1, 0;

	cd <<-cos(Robot.pos.z), -sin(Robot.pos.z), 0,
		 sin(Robot.pos.z),  -cos(Robot.pos.z), 0,
		0, 0, -1;

	x1 << pose[0],0,pose[1],0,pose[2],0;
	y1=c*x1+cd*RobotMat;
	//cout<<pose[0]<<" "<<pose[0]<<" "<<pose[2]<<endl;
	xb=x1;
	before = observe;
	//cout<<"xb	"<<xb<<endl;
	time = nowtime;
	//cout<<"xb	"<<y1<<endl;
	before.pos.x = y1(0, 0);
	before.pos.y = y1(1, 0);
	before.pos.z = y1(2, 0);
	before.vel.x = 0;
	before.vel.y = 0;
	before.vel.z = 0;
	return before;
}
wagon kalmanfilter::predictStep(wagon observe,double nowtime,robot Robot,bool checkGrasp)
{
	/*cout<<"prediction input"<<endl;
	cout<<x1<<endl;*/
	RobotMat << Robot.pos.x,
		Robot.pos.y,
		Robot.pos.z;

	//cout<<RobotMat<<endl;
	//cout << "pridict	" << endl;
	double dt = (nowtime - time);
	//cout << "	dt	" << dt << endl;
	time = nowtime;
	checkGrasp = true;
	//cout<<"1"<<endl;
	if (checkGrasp)
	{
		A << 1, dt, 0, 0, 0, 0,
			0, 1, 0, 0, 0, 0,
			0, 0, 1, dt, 0, 0,
			0, 0, 0, 1, 0, 0,
			0, 0, 0, 0, 1, dt,
			0, 0, 0, 0, 0, 1;
		
		b << 0, 0, 0,
			dt, 0, 0,
			0, 0, 0,
			0, dt, 0,
			0, 0, 0,
			0, 0, dt;
	}
	else
	{
		x1(1,0)=0;
		x1(3,0)=0;
		x1(5,0)=0;
		A << 1, dt, 0, 0, 0, 0,
			0, 1, 0, 0, 0, 0,
			0, 0, 1, dt, 0, 0,
			0, 0, 0, 1, 0, 0,
			0, 0, 0, 0, 1, dt,
			0, 0, 0, 0, 0, 1;
		
		b << 0, 0, 0,
			dt, 0, 0,
			0, 0, 0,
			0, dt, 0,
			0, 0, 0,
			0, 0, dt;
	}

	c << cos(Robot.pos.z), 0,  sin(Robot.pos.z), 0, 0, 0,
		 -sin(Robot.pos.z), 0,  cos(Robot.pos.z), 0, 0, 0,
		0, 0, 0, 0, 1, 0;

	cd <<-cos(Robot.pos.z), -sin(Robot.pos.z), 0,
		 sin(Robot.pos.z),  -cos(Robot.pos.z), 0,
		0, 0, -1;
	//cout<<"3"<<y1<<endl;
	xb = A*x1;//絶対座標系
	pb = A*p1*(A.transpose()) + b*sigmaV*(b.transpose());
	g = pb*c.transpose()*((c*pb*c.transpose() + R).inverse());

	yb=c*xb+cd*RobotMat;
	before = observe;

	//cout << "xb	" << xb << endl << endl;
	//cout << "yb	" << yb << endl << endl;

	//cout<<"xb	"<<xb(0, 0)<<endl;
	before.pos.x = yb(0, 0);
	before.pos.y = yb(1, 0);
	before.pos.z = yb(2, 0);
	before.vel.x = xb(1,0);
	before.vel.y = xb(3,0);
	before.vel.z = xb(5,0);
	/*cout<<"prediction output"<<endl;
	cout<<x1<<endl;*/
	return before;
}
wagon kalmanfilter::getNotFilteringOutput(wagon predict,wagon observe,robot Robot)
{
	RobotMat << Robot.pos.x,
		Robot.pos.y,
		Robot.pos.z;
	
	c << cos(Robot.pos.z), 0,  sin(Robot.pos.z), 0, 0, 0,
		 -sin(Robot.pos.z), 0,  cos(Robot.pos.z), 0, 0, 0,
		0, 0, 0, 0, 1, 0;

	cd <<-cos(Robot.pos.z), -sin(Robot.pos.z), 0,
		 sin(Robot.pos.z),  -cos(Robot.pos.z), 0,
		0, 0, -1;

	
	//cout << "filtering	" << endl;
	//cout << "observe1  " << observe.pos.x << "  " << observe.pos.y << "  " << observe.pos.z << endl;
	int count = 0;
	while (1)
	{
		if (observe.pos.z - predict.pos.z > 6.28*0.9)//360くらいの差が出ているとき
		{
			observe.pos.z -= 3.14 * 2;
		}
		else if (observe.pos.z - predict.pos.z < -6.28*0.9)//360度くらい差が出ているとき
		{
			observe.pos.z += 3.14 * 2;
		}
		else
		{
			break;
		}
		//cout << "observe2  " << observe.pos.x << "  " << observe.pos.y << "  " << observe.pos.z << endl;
	}

	//cout << "observe3  " << observe.pos.x << "  " << observe.pos.y << "  " << observe.pos.z << endl;
	if(abs((observe.pos.z-3.14)-predict.pos.z)<abs((observe.pos.z)-predict.pos.z))
	{
		observe.pos.z-=3.14;
	}
	else if(abs((observe.pos.z+3.14)-predict.pos.z)<abs((observe.pos.z)-predict.pos.z))
	{
		observe.pos.z+=3.14;
	}
	//cout << "observe3  " << observe.pos.x << "  " << observe.pos.y << "  " << observe.pos.z << endl;
	y1 << observe.pos.x, observe.pos.y, observe.pos.z;
	xO = PseudoInverse(c)*(y1-cd*RobotMat);
	
	//cout << "x1	" << x1 << endl << endl;

	//cout << "p1" << p1 << endl << endl;

	before = predict;
	before.pos.x = y1(0, 0);
	before.pos.y = y1(1, 0);
	before.pos.z = y1(2, 0);
	before.posWorld.x = xO(0, 0);
	before.posWorld.y = xO(2, 0);
	before.posWorld.z = xO(4, 0);
	before.vel.x = x1(1,0);
	before.vel.y = x1(3,0);
	before.vel.z = x1(5,0);
	//cout << "yaw  " << x1(4,0) << "  "  << observe.pos.z << "  " << robot[2] << "  "<<yb(2, 0)<< "	"<<x1(4,0)-robot[2]<<endl << endl;

	return before;
}
wagon kalmanfilter::filteringStep(wagon predict,wagon observe,robot Robot)
{
	RobotMat << Robot.pos.x,
		Robot.pos.y,
		Robot.pos.z;
	
	c << cos(Robot.pos.z), 0,  sin(Robot.pos.z), 0, 0, 0,
		 -sin(Robot.pos.z), 0,  cos(Robot.pos.z), 0, 0, 0,
		0, 0, 0, 0, 1, 0;

	cd <<-cos(Robot.pos.z), -sin(Robot.pos.z), 0,
		 sin(Robot.pos.z),  -cos(Robot.pos.z), 0,
		0, 0, -1;

	
	//cout << "filtering	" << endl;
	//cout << "observe1  " << observe.pos.x << "  " << observe.pos.y << "  " << observe.pos.z << endl;
	int count = 0;
	while (1)
	{
		if (observe.pos.z - predict.pos.z > 6.28*0.9)//360くらいの差が出ているとき
		{
			observe.pos.z -= 3.14 * 2;
		}
		else if (observe.pos.z - predict.pos.z < -6.28*0.9)//360度くらい差が出ているとき
		{
			observe.pos.z += 3.14 * 2;
		}
		else
		{
			break;
		}
		//cout << "observe2  " << observe.pos.x << "  " << observe.pos.y << "  " << observe.pos.z << endl;
	}

	//cout << "observe3  " << observe.pos.x << "  " << observe.pos.y << "  " << observe.pos.z << endl;
	if(abs((observe.pos.z-3.14)-predict.pos.z)<abs((observe.pos.z)-predict.pos.z))
	{
		observe.pos.z-=3.14;
	}
	else if(abs((observe.pos.z+3.14)-predict.pos.z)<abs((observe.pos.z)-predict.pos.z))
	{
		observe.pos.z+=3.14;
	}
	//cout << "observe3  " << observe.pos.x << "  " << observe.pos.y << "  " << observe.pos.z << endl;
	y1 << observe.pos.x, observe.pos.y, observe.pos.z;
	
	x1 = xb + g*(y1 - c*xb-cd*RobotMat);
	p1 = (I - g*c)*pb;

	yb=c*x1+cd*RobotMat;
	
	//cout << "x1	" << x1 << endl << endl;

	//cout << "p1" << p1 << endl << endl;

	before = predict;
	before.pos.x = yb(0, 0);
	before.pos.y = yb(1, 0);
	before.pos.z = yb(2, 0);
	before.posWorld.x = x1(0, 0);
	before.posWorld.y = x1(2, 0);
	before.posWorld.z = x1(4, 0);
	before.vel.x = x1(1,0);
	before.vel.y = x1(3,0);
	before.vel.z = x1(5,0);
	//cout << "yaw  " << x1(4,0) << "  "  << observe.pos.z << "  " << robot[2] << "  "<<yb(2, 0)<< "	"<<x1(4,0)-robot[2]<<endl << endl;

	return before;
}

wagon kalmanfilter::filteringStep(robot Robot)
{
	//cout << "filtering NoData	" << endl;
	x1 = xb;
	p1 = pb;

	RobotMat << Robot.pos.x,
		Robot.pos.y,
		Robot.pos.z;
	
	c << cos(Robot.pos.z), 0,  sin(Robot.pos.z), 0, 0, 0,
		 -sin(Robot.pos.z), 0,  cos(Robot.pos.z), 0, 0, 0,
		0, 0, 0, 0, 1, 0;

	cd <<-cos(Robot.pos.z), -sin(Robot.pos.z), 0,
		 sin(Robot.pos.z),  -cos(Robot.pos.z), 0,
		0, 0, -1;

	yb=c*xb+cd*RobotMat;
	
	before.pos.x = yb(0, 0);
	before.pos.y = yb(1, 0);
	before.pos.z = yb(2, 0);
	before.posWorld.x = x1(0, 0);
	before.posWorld.y = x1(2, 0);
	before.posWorld.z = x1(4, 0);
	before.vel.x = x1(1,0);
	before.vel.y = x1(3,0);
	before.vel.z = x1(5,0);
	return before;
}
