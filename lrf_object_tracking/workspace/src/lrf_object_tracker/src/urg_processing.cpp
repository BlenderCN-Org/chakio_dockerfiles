#include "ofMain.h"
#include "urg_processing.h"
#include <iostream>
#include<fstream>
#include<iostream>
#include<string>
#include<sstream> 
//#include <Eigen/Dense>

#define M_PI 3.14
using namespace std;
using namespace Eigen;

URG_processsing::URG_processsing()
{

}
void URG_processsing::setDataFromURG1(vector<long>data)
{
	dataFromURG1 = data;
}
void URG_processsing::setURG1(URG urg)
{
	URG1 = urg;
}
void URG_processsing::setDrawRange(double DrawRange)
{
	drawRange = DrawRange;
	rangeVal = drawRange / (ofGetHeight()/2);
}

void URG_processsing::drawData()
{
	ofSetLineWidth(1);
	ofPoint center(ofGetWidth() / 2-URG1.pos.y/ rangeVal, (ofGetHeight()/2)-URG1.pos.x/ rangeVal+ofGetHeight()/4);
	if(URG1.pos.x<0)
	{
		ofSetColor(0, 180, 50,120);
	}
	else
	{
		ofSetColor(0, 50, 180,120);
	}
	for (int i = 0; i < dataFromURG1.size(); i++)
	{
		double theta=URG1.angleRange*(double)(dataFromURG1.size() - i)/ (double)dataFromURG1.size()/ 180 * M_PI + M_PI/2+(2*M_PI-URG1.angleRange/180*M_PI)/2-URG1.pos.z;
		
		ofDrawLine(center, ofPoint(center.x+ dataFromURG1[i] / rangeVal  * cos(theta), center.y+dataFromURG1[i] / rangeVal * sin(theta)));
		//ofDrawCircle(ofPoint(ofGetWidth() / 2 + data[i] / rangeVal  * cos((data.size() - i)*(double)step / 180 * M_PI + M_PI/2+M_PI/3), data[i] / rangeVal * sin((data.size() - i)*(double)step / 180 * M_PI + M_PI/2 + M_PI / 3) + (ofGetHeight()*0.8)),1);
		/*if (data[i] < urg.maxLengthH
		{
			ofSetColor(200, 0, 200,255);
			ofDrawCircle(ofPoint(center.x+ data[i] / rangeVal * cos(theta), center.y+data[i] / rangeVal * sin(theta)), 1);
		}*/
		//cout << i <<" "<<theta<< endl;
	}
}

void URG_processsing::findPoints(int length,double minWidth,double maxWidth,vector<double>SearchRange )
{
	bool find = false;//�������t���O
	bool findout = false;//���̂̏I�_�t���O
	double findpos[6] = { 0,0,0,0,0,0 };//���̂����݂���ł��낤�ꏊ�̕��ϒl0:���A1:�����܂ł̋���,2:x,3:y,4:�n�܂��i,5:�I����i
	double findposnum = 0;//�����̃��[�U�[��Ղ�����
	double thinglength = 0;//���̂̉���
	vector<vector<double>> thingposes;
	vector<double> thingpos;
	thingpos.resize(6);
	thingposes.clear();
	double minLength;
	double aveLength;
	int minPos=0;
	for (int i = 0; i < dataFromURG1.size(); i++)
	{
		if (dataFromURG1[i] < URG1.maxLength)//���[�U�[���Z�����ǂ���
		{
			if (find)//�f�[�^�̒����̘A�����̊m�F
			{
				if (abs(dataFromURG1[i] - dataFromURG1[i - 1]) < length)
				{
					findposnum++;
					findpos[0] += i;
					aveLength += dataFromURG1[i];
					if(minLength > dataFromURG1[i])
					{
						minLength= dataFromURG1[i];
						minPos = i;
					}
				}
				else
				{
					findout = true;
					findpos[5] =findpos[4]+ findposnum-1;
				}
				//cout << data[i] << endl;
			}
			else
			{
				findpos[0] = i;
				minLength = dataFromURG1[i];
				aveLength = dataFromURG1[i];
				findposnum=1;
				
				find = true;
				findpos[4] = i;
			}
		}
		else
		{
			if (find)
			{
				findout = true;
				findpos[5] = findpos[4] + findposnum - 1;
			}
		}
		//cout << i << endl;
		if (findout)//���̂̏I�_�������̏���
		{
			aveLength = aveLength/findposnum;
			findpos[0] = ((int)findpos[0] / findposnum);//�^��
			findpos[1] = minLength;
			thinglength = (findpos[1] + (tan(findposnum* URG1.angleRange/(double)dataFromURG1.size() / 180.0 * M_PI / 2)*findpos[1]))*tan(findposnum* URG1.angleRange/dataFromURG1.size()/ 180 * M_PI / 2) * 2;
			findpos[0] *= URG1.angleRange/(double)dataFromURG1.size()*(M_PI / 180.0);//
			findpos[2] = -(findpos[1]*1.0+40) * cos(findpos[0] - (URG1.angleRange/180.0*M_PI-M_PI)/2.0-URG1.pos.z)+URG1.pos.y;
			findpos[3] = (findpos[1]*1.0+40) * sin(findpos[0] - (URG1.angleRange/180.0*M_PI-M_PI)/2.0-URG1.pos.z)+URG1.pos.x;
			thingpos[0] =findpos[3] ;//ロボット座標系x
			thingpos[1] =findpos[2] ;//ロボット座標系y
			thingpos[2] = thinglength;
			thingpos[3] = findpos[4];
			thingpos[4] = findpos[5];
			thingposes.push_back(thingpos);

			find = false;
			findpos[0] = 0;
			findposnum = 0;
			findout = false;
			thingpos[3] = 0;
			thingpos[4]=0;
		}
		//cout <<  i << endl;
	}
	if (find)//�Ō�܂ŕ��̂̏I�_�����Ȃ������ꍇ�ɏI�_�̏������
	{
		findpos[0] = (findpos[0] / findposnum);//�^��
		findpos[1] = dataFromURG1[(int)findpos[0]];
		thinglength = (findpos[1] + (tan(findposnum* URG1.angleRange/dataFromURG1.size() / 180.0 * M_PI / 2)*findpos[1]))*tan(findposnum*URG1.angleRange/dataFromURG1.size() / 180.0 * M_PI / 2.0) * 2.0;
		findpos[0] *= URG1.angleRange/dataFromURG1.size()*(M_PI / 180);
		findpos[2] = -(findpos[1]*1.0+0.02) * cos(findpos[0]- (URG1.angleRange/180*M_PI-M_PI)/2-URG1.pos.z)+URG1.pos.y;
		findpos[3] = (findpos[1]*1.0 +0.02) * sin(findpos[0]- (URG1.angleRange/180*M_PI-M_PI)/2-URG1.pos.z)+URG1.pos.x;
		thingpos[0] =findpos[3] ;//ロボット座標系x
		thingpos[1] =findpos[2] ;//ロボット座標系y
		thingpos[2] = thinglength;
		thingpos[3] = findpos[4];
		thingpos[4] = dataFromURG1.size()-1;
		thingposes.push_back(thingpos);

		findpos[0] = 0;
		findposnum = 0;
		thingpos[3] = 0;
		thingpos[4] = 0;
	}
	//cout << "find" << endl;
	bool eraseflag = true;


	for (int i = 0; i < thingposes.size(); i++)
	{
		//cout<<"thingposes="<<thingposes.size()<<endl;
		//cout<<"i="<<i<<endl;
		eraseflag = true;
		double findposDeg ;
		findposDeg=atan2(thingposes[i][1],thingposes[i][0]);
		if (sqrt( pow(thingposes[i][0],2) + pow(thingposes[i][1],2) ) < SearchRange[0])
		{
			if (findposDeg<SearchRange[1] && findposDeg>-SearchRange[1])
			{
				if (thingposes[i][2] >minWidth && thingposes[i][2] < maxWidth)
				{
					//cout<<thingposes[i][0]<<"	"<<thingposes[i][1]<<"	"<<findposDeg<<endl;
					eraseflag = false;//��ɍ���������	
				}
			}
		}
		if (eraseflag)
		{
			thingposes.erase(thingposes.begin() +i);
			i -= 1;
			//cout<<"erace"<<endl;
		}
	}
	
	foundPoints = thingposes;
}

void URG_processsing::drawFoundPoints(bool extracted)
{
	ofSetLineWidth(2);
	if(extracted)
	{
		ofSetColor(0, 255, 0);	
		ofFill();
		for (int i = 0; i < extractedPoints.size(); i++)
		{
			double radius;
			radius =((double)extractedPoints[i][2] / rangeVal/2); 
			
			ofDrawCircle(ofPoint(-(double)extractedPoints[i][1] / rangeVal + ofGetWidth() / 2, -(double)extractedPoints[i][0] / rangeVal + (ofGetHeight()/2)+ofGetHeight()/4),radius);
		}
	}
	else
	{
		ofSetColor(255, 0, 0);	
		ofNoFill();
		for (int i = 0; i < foundPoints.size(); i++)
		{
			double radius;
			radius =((double)foundPoints[i][2] / rangeVal/2); 
			
			ofDrawCircle(ofPoint(-(double)foundPoints[i][1] / rangeVal + ofGetWidth() / 2, -(double)foundPoints[i][0] / rangeVal + (ofGetHeight()/2)+ofGetHeight()/4),radius);
		}
	}
	
	
}
void URG_processsing::extractPoints(wagon wagonState, double radius)
{
	vector< vector<double> > extractedPos;
	vector< vector<double> > distances;
	bool detect[4]={false,false,false,false};
	double bigvalue = 20000;


	/*double rangeVal = 2000 / (ofGetHeight()/2);
	
	ofSetColor(255,255,0);
	for (int i = 0; i < 4; i++)
	{
		ofFill();
		double radius =20;
		ofDrawCircle(ofPoint(-(double)(wagonState.frame[i].y + wagonState.pos.y)/ rangeVal + ofGetWidth() / 2, -(double)(wagonState.frame[i].x + wagonState.pos.x) / rangeVal + (ofGetHeight()/2)+ofGetHeight()/4),radius);
	}*/
	//cout << "1" << endl;
	for (int i = 0; i < 4; i++)
	{
		vector<double> distance;
		for (int j = 0; j < foundPoints.size(); j++)
		{
			double sample = sqrt(pow((wagonState.frame[i].x + wagonState.pos.x) - foundPoints[j][0], 2) + pow((wagonState.frame[i].y + wagonState.pos.y) - foundPoints[j][1], 2));
			if (sample < radius)
			{
				distance.push_back(sample);
			}
			else
			{
				distance.push_back(bigvalue);
			}
		}
		distances.push_back(distance);
	}

	vector<candidate> candidates;
	//それぞれの観測点とフレームの距離に基づき、どれかのフレームのゲート内にある観測点をピックアップする
	for(int i=0;i<foundPoints.size();i++)
	{
		//それぞれの観測点が各フレームのゲートの中にあるかを確認
		bool inGate=false;
		for(int frameNum=0;frameNum<4;frameNum++)
		{
			if(distances[frameNum][i]<bigvalue)
			{
				inGate = true;
			}
		}

		//ゲートの中にある場合はcandidateに追加
		if(inGate)
		{
			candidate tempCandidate;
			//位置の格納
			tempCandidate.x 		= foundPoints[i][0];
			tempCandidate.y 		= foundPoints[i][1];
			tempCandidate.radius 	= foundPoints[i][2];
			//フレームとの距離の格納
			for(int frameNum=0;frameNum<4;frameNum++)
			{
				tempCandidate.distance[frameNum] = distances[frameNum][i];
			}
			candidates.push_back(tempCandidate);
		}
	}

	
	//cout<<"candidatesNum:"<<candidates.size()<<endl;
	if(candidates.size()<4)
	{
		double diffrerence  =  4-candidates.size();
		for(int i=0;i<diffrerence;i++)
		{
			//cout<<i<<endl;
			candidate tempCandidate;
			//位置の格納
			tempCandidate.x 		= 0;
			tempCandidate.y 		= 0;
			tempCandidate.radius 	= 0;
			//フレームとの距離の格納
			for(int frameNum=0;frameNum<4;frameNum++)
			{
				tempCandidate.distance[frameNum] = bigvalue;
			}
			candidates.push_back(tempCandidate);	
		}
	}
	//cout<<"new candidatesNum:"<<candidates.size()<<endl;

	double minSumDistance=10000000000;
	int minIndex[4]={0,0,0,0};
	//cout<<"getCombination"<<endl;
	for(int one=0;one<candidates.size();one++)
	{
		int selectedIndex[4]={one,-1,-1,-1};
		//cout<<"one:"<<one<<endl;
		for(int two=0;two<candidates.size();two++)
		{
			//cout<<"two:"<<two<<endl;
			if(two!=one)
			{
				selectedIndex[1] = two;
				for(int three=0; three<candidates.size();three++)
				{
					//cout<<"three:"<<three<<endl;
					if(one!=three && two!=three)
					{
						selectedIndex[2] = three;
						for(int four = 0; four<candidates.size();four++)
						{
							//cout<<"four:"<<four<<endl;
							if(one!=four && two!=four && three!=four)
							{
								selectedIndex[3] = four;
								
								double sumDistance = 0;
								for(int frameNum=0;frameNum<4;frameNum++)
								{
									//cout<<frameNum<<":"<<selectedIndex[frameNum]<<"   ";
									sumDistance += candidates[selectedIndex[frameNum]].distance[frameNum];
								}
								//cout<<endl;
								if(sumDistance<minSumDistance)
								{
									minSumDistance = sumDistance;
									for(int frameNum=0;frameNum<4;frameNum++)
									{
										minIndex[frameNum]=selectedIndex[frameNum];
									}
								}
								//cout<<minSumDistance<<endl;
							}
						}
					}
				}
			}
		}
	}



	//cout<<"setObserve"<<endl;
	if(candidates.size()>0)
	{
		for (int i = 0; i < 4; i++)
		{
			vector<double> pos;
			//cout<<"minIndex:"<<i<<","<<minIndex[i]<<endl;
			//cout<<"judge"<<endl;
			if (candidates[minIndex[i]].distance[i]< bigvalue)
			{
				//cout<<"set"<<endl;
				pos.push_back(candidates[minIndex[i]].x);
				pos.push_back(candidates[minIndex[i]].y);
				pos.push_back(candidates[minIndex[i]].radius);
				extractedPos.push_back(pos);
			}
			else
			{
				//cout<<"set"<<endl;
				pos.push_back(0);
				pos.push_back(0);
				pos.push_back(0);
				extractedPos.push_back(pos);
			}
			
		}
	}
	//cout<<"returnSize:"<<thingsposR.size()<<endl;
	extractedPoints = extractedPos;
}
vector<vector<double>> URG_processsing::getExtractedPoints()
{
	return extractedPoints;
}

int URG_processsing::getCandidateNum(wagon wagonState, double radius)
{
	int num=0;

	for (int j = 0; j < foundPoints.size(); j++)
	{
		double sample = sqrt(pow(wagonState.pos.x - foundPoints[j][0], 2) + pow(wagonState.pos.y - foundPoints[j][1], 2));
		if (sample < radius)
		{
			num++;
		}
	}

	return num;
}
wagon URG_processsing::getWagonPose(wagon observedWagon)
{
	bool isDetected[4]={false,false,false,false};
	int detectedNum=0;
	vector<vector<double>>thingsposDetected;
	for(int frameNum=0;frameNum<4;frameNum++)
	{
		//cout<<"findPoint:"<<frameNum<<":"<<findpoints[frameNum][0]<<" "<<findpoints[frameNum][1]<<endl;
		//見つけられなかったframeの物体の大きさthingspos[frameNum][2]は0
		if(extractedPoints[frameNum][2]>0)
		{
			detectedNum++;
			vector<double>detectedPos;
			detectedPos.push_back(extractedPoints[frameNum][0]);
			detectedPos.push_back(extractedPoints[frameNum][1]);
			detectedPos.push_back(frameNum);
			thingsposDetected.push_back(detectedPos);
			isDetected[frameNum] = true;
		}
	}
	observedWagon.pos.x=0;
	observedWagon.pos.y=0;
	observedWagon.pos.z=0;
	if(detectedNum==4)
	{
		//ポジションは平均
		for(int frameNum=0;frameNum<4;frameNum++)
		{
			observedWagon.pos.x += thingsposDetected[frameNum][0];
			observedWagon.pos.y += thingsposDetected[frameNum][1];
		}
		observedWagon.pos.x /= 4;
		observedWagon.pos.y /= 4;
		double directX=0;
		double directY=0;
		double angle=0;
		 
		directX += cos(atan2(thingsposDetected[1][1]-thingsposDetected[0][1],thingsposDetected[1][0]-thingsposDetected[0][0])-M_PI/2.0);
		directY += sin(atan2(thingsposDetected[1][1]-thingsposDetected[0][1],thingsposDetected[1][0]-thingsposDetected[0][0])-M_PI/2.0);

		directX += cos(atan2(thingsposDetected[2][1]-thingsposDetected[1][1],thingsposDetected[2][0]-thingsposDetected[1][0])-M_PI);
		directY += sin(atan2(thingsposDetected[2][1]-thingsposDetected[1][1],thingsposDetected[2][0]-thingsposDetected[1][0])-M_PI);

		directX += cos(atan2(thingsposDetected[3][1]-thingsposDetected[2][1],thingsposDetected[3][0]-thingsposDetected[2][0])+M_PI/2.0);
		directY += sin(atan2(thingsposDetected[3][1]-thingsposDetected[2][1],thingsposDetected[3][0]-thingsposDetected[2][0])+M_PI/2.0);
		
		directX += cos(atan2(thingsposDetected[0][1]-thingsposDetected[3][1],thingsposDetected[0][0]-thingsposDetected[3][0]));
		directY += sin(atan2(thingsposDetected[0][1]-thingsposDetected[3][1],thingsposDetected[0][0]-thingsposDetected[3][0]));
		
		angle= atan2(directY,directX);
		
		observedWagon.pos.z = angle;
		//cout<<"x:"<<observedWagon.pos.x<<endl;
		//cout<<"y:"<<observedWagon.pos.y<<endl;
		//cout<<"z:"<<observedWagon.pos.z<<endl;
	}
	else if(detectedNum==3)
	{
		double wagonRadius = sqrt(pow(observedWagon.length.x,2)+pow(observedWagon.length.y,2))/2;
		vector<vector<vector<double>>> elements;
		vector<double>ele;
		ele.resize(4);
		
		//cout << "1" << endl;
		MatrixXd Matrix(3, 3), MatrixInverse(3, 3);
		for (int i = 0; i < 3; i++)
		{
			for (int j = 0; j < 3; j++)
			{
				Matrix(i, j) = 0;
			}
		}
		VectorXd subMatrix(3);
		for (int i = 0; i < 3; i++)
		{
			subMatrix(i) = 0;
		}

		VectorXd ansMatrix(3);
		vector<double> circleElemnt;
		circleElemnt.resize(3);
	
		for (int i = 0; i < thingsposDetected.size(); i++)
		{
			vector<vector<double>> element;
			double Xi = thingsposDetected[i][0];
			double Yi = thingsposDetected[i][1];
			ele[0] = pow(Xi, 2)*pow(Yi, 0);
			ele[1] = pow(Xi, 1)*pow(Yi, 1);
			ele[2] = pow(Xi, 1)*pow(Yi, 0);
			ele[3] = -pow(Xi, 3)*pow(Yi, 0) - pow(Xi, 1)*pow(Yi, 2)+wagonRadius*pow(Xi, 1);
			element.push_back(ele);

			ele[0] = pow(Xi, 1)*pow(Yi, 1);
			ele[1] = pow(Xi, 0)*pow(Yi, 2);
			ele[2] = pow(Xi, 0)*pow(Yi, 1);
			ele[3] = -pow(Xi, 2)*pow(Yi, 1) - pow(Xi, 0)*pow(Yi, 3)+wagonRadius*pow(Yi, 1);
			element.push_back(ele);

			ele[0] = pow(Xi, 1)*pow(Yi, 0);
			ele[1] = pow(Xi, 0)*pow(Yi, 1);
			ele[2] = pow(Xi, 0)*pow(Yi, 0);
			ele[3] = -pow(Xi, 2)*pow(Yi, 0)- pow(Xi, 0)*pow(Yi, 2)+wagonRadius;
			element.push_back(ele);

			elements.push_back(element);
		}
		//cout << "2" << endl;
		for (int e = 0; e < elements.size(); e++)
		{
			for (int i = 0; i < 3; i++)
			{
				for (int j = 0; j < 3; j++)
				{
					Matrix(i, j) += elements[e][i][j];
				}
				subMatrix(i) += elements[e][i][3];
			}
		}
		//cout << "3" << endl;
		MatrixInverse = Matrix.inverse();
		ansMatrix = MatrixInverse*subMatrix;

		observedWagon.pos.x = -ansMatrix(0) / 2;
		observedWagon.pos.y = -ansMatrix(1) / 2;

		double angle=0;
		double directX=0;
		double directY=0;
		if(isDetected[0]&&isDetected[1])
		{
			directX += cos(atan2(extractedPoints[1][1]-extractedPoints[0][1],extractedPoints[1][0]-extractedPoints[0][0])-M_PI/2.0);
			directY += sin(atan2(extractedPoints[1][1]-extractedPoints[0][1],extractedPoints[1][0]-extractedPoints[0][0])-M_PI/2.0);
		}
		if(isDetected[1]&&isDetected[2])
		{
			directX += cos(atan2(extractedPoints[2][1]-extractedPoints[1][1],extractedPoints[2][0]-extractedPoints[1][0])-M_PI);
			directY += sin(atan2(extractedPoints[2][1]-extractedPoints[1][1],extractedPoints[2][0]-extractedPoints[1][0])-M_PI);
		}
		if(isDetected[2]&&isDetected[3])
		{
			directX += cos(atan2(extractedPoints[3][1]-extractedPoints[2][1],extractedPoints[3][0]-extractedPoints[2][0])+M_PI/2.0);
			directY += sin(atan2(extractedPoints[3][1]-extractedPoints[2][1],extractedPoints[3][0]-extractedPoints[2][0])+M_PI/2.0);
		}
		if(isDetected[3]&&isDetected[0])
		{
			directX += cos(atan2(extractedPoints[0][1]-extractedPoints[3][1],extractedPoints[0][0]-extractedPoints[3][0]));
			directY += sin(atan2(extractedPoints[0][1]-extractedPoints[3][1],extractedPoints[0][0]-extractedPoints[3][0]));
		}
		angle= atan2(directY,directX);
		observedWagon.pos.z = angle;
		//cout<<"x:"<<observedWagon.pos.x<<endl;
		//cout<<"y:"<<observedWagon.pos.y<<endl;
		//cout<<"z:"<<observedWagon.pos.z<<endl;
	}
	else if(detectedNum==2)
	{
		observedWagon.length.x = 300;
		observedWagon.length.y = 500;
		double angle =atan2(observedWagon.length.y,observedWagon.length.x);
		double wagonRadius = sqrt(pow(observedWagon.length.x,2)+pow(observedWagon.length.y,2))/2;
		vector<vector<double>> findFrames;

		
		double center[2];
		double yaw;
		if(isDetected[0] && isDetected[1])
		{
			//cout<<"0&1"<<endl;
			yaw=atan2(extractedPoints[1][1]-extractedPoints[0][1],extractedPoints[1][0]-extractedPoints[0][0])-M_PI/2.0;
			double preCenter[2];
			preCenter[0]=0.5*(extractedPoints[0][0]+extractedPoints[1][0]);
			preCenter[1]=0.5*(extractedPoints[0][1]+extractedPoints[1][1]);
			
			center[0] = preCenter[0]+observedWagon.length.x/2.0*cos(yaw+M_PI);
			center[1] = preCenter[1]+observedWagon.length.x/2.0*sin(yaw+M_PI);

			//cout<<"precenter:"<<preCenter[0]<<" "<<preCenter[1]<<endl;
			//cout<<"center:"<<center[0]<<" "<<center[1]<<endl;
		}
		else if(isDetected[2] && isDetected[3])
		{
			//cout<<"2&3"<<endl;
			yaw=atan2(extractedPoints[3][1]-extractedPoints[2][1],extractedPoints[3][0]-extractedPoints[2][0])+M_PI/2.0;
			double preCenter[2];
			preCenter[0]=0.5*(extractedPoints[2][0]+extractedPoints[3][0]);
			preCenter[1]=0.5*(extractedPoints[2][1]+extractedPoints[3][1]);
			center[0] = preCenter[0]+observedWagon.length.x/2.0*cos(yaw);
			center[1] = preCenter[1]+observedWagon.length.x/2.0*sin(yaw);
			//cout<<"precenter:"<<preCenter[0]<<" "<<preCenter[1]<<endl;
			//cout<<"center:"<<center[0]<<" "<<center[1]<<endl;
		}
		else if(isDetected[1] && isDetected[2])
		{
			//cout<<"1&2"<<endl;
			yaw=atan2(extractedPoints[2][1]-extractedPoints[1][1],extractedPoints[2][0]-extractedPoints[1][0])-M_PI;
			double preCenter[2];
			preCenter[0]=0.5*(extractedPoints[1][0]+extractedPoints[2][0]);
			preCenter[1]=0.5*(extractedPoints[1][1]+extractedPoints[2][1]);
			center[0] = preCenter[0]+(observedWagon.length.y/2.0)*cos(yaw-M_PI/2.0);
			center[1] = preCenter[1]+(observedWagon.length.y/2.0)*sin(yaw-M_PI/2.0);
			//cout<<"precenter:"<<preCenter[0]<<" "<<preCenter[1]<<endl;
			//cout<<"center:"<<center[0]<<" "<<center[1]<<endl;
		}
		else if(isDetected[3] && isDetected[0])
		{
			//cout<<"3&0"<<endl;
			yaw=atan2(extractedPoints[0][1]-extractedPoints[3][1],extractedPoints[0][0]-extractedPoints[3][0]);
			double preCenter[2];
			preCenter[0]=0.5*(extractedPoints[3][0]+extractedPoints[0][0]);
			preCenter[1]=0.5*(extractedPoints[3][1]+extractedPoints[0][1]);
			center[0] = preCenter[0]+(observedWagon.length.y/2.0)*cos(yaw+M_PI/2.0);
			center[1] = preCenter[1]+(observedWagon.length.y/2.0)*sin(yaw+M_PI/2.0);
			//cout<<"precenter:"<<preCenter[0]<<" "<<preCenter[1]<<endl;
			//cout<<"center:"<<center[0]<<" "<<center[1]<<endl;
		}
		else if(isDetected[0] && isDetected[2])
		{
			yaw=atan2(extractedPoints[0][1]-extractedPoints[2][1],extractedPoints[0][0]-extractedPoints[2][0])+angle;
			center[0]=0.5*(extractedPoints[0][0]+extractedPoints[2][0]);
			center[1]=0.5*(extractedPoints[0][1]+extractedPoints[2][1]);
		}
		else if(isDetected[1] && isDetected[3])
		{
			yaw=atan2(extractedPoints[1][1]-extractedPoints[3][1],extractedPoints[1][0]-extractedPoints[3][0])-angle;
			center[0]=0.5*(extractedPoints[1][0]+extractedPoints[3][0]);
			center[1]=0.5*(extractedPoints[1][1]+extractedPoints[3][1]);
		}

		
		observedWagon.pos.x = center[0];
		observedWagon.pos.y = center[1];
		observedWagon.pos.z = yaw;
		//cout<<"x:"<<observedWagon.pos.x<<endl;
		//cout<<"y:"<<observedWagon.pos.y<<endl;
		//cout<<"z:"<<observedWagon.pos.z<<endl;

	}
	return observedWagon;

}

/* 
vector<vector<double>> URG_processsing::GetWagonVertex(vector<vector<double>> findpoints, vector<double>CircleElement,double range)
{
	//cout << "3" << endl;
	if (findpoints.size() == 3)
	{
		double framelength[3];
		double angle[3], gangle[3],frameangle[3],gframeangle[3];
		double sumangle[2] = { 0,0 };
		double maxAngle;
		double maxAnglePos;
		vector<int> framenumber;
		for (int i = 0; i < findpoints.size(); i++)
		{
			framenumber.push_back(i);
		}
	
		for (int i = 0; i < findpoints.size(); i++)
		{
			angle[i] = atan2(findpoints[i][1] - CircleElement[1], findpoints[i][0] - CircleElement[0]);
			if (angle[i] < 0)
			{
				angle[i] += 2 * M_PI;
			}
		}
		
		for (int i = 0; i < 3; i++)
		{
			gangle[i] = angle[i];
		}
		sort(angle, angle + findpoints.size());
	
		for (int i = 0; i < findpoints.size(); i++)
		{
			for (int j = 0; j < findpoints.size(); j++)
			{
				if (gangle[i] == angle[j])
				{
					framenumber[i] = j;
				}
			}
			
		}

		//cout << "3" << endl;
		frameangle[0] = angle[1] - angle[0];
		frameangle[1] = angle[2] - angle[1];
		frameangle[2] = angle[0]+2*M_PI - angle[2];
		for (int i = 0; i < 3; i++)
		{
			gframeangle[i] = frameangle[i];
		}
		
		sort(frameangle, frameangle+3);
		maxAngle = frameangle[2];

		for (int i = 0; i < 3; i++)
		{
			if (maxAngle == gframeangle[i])
			{
				//cout << "max" <<i<< endl;
				maxAnglePos = i;
			}
		}
		vector<double>  additionalvertex;
		for (int i = 0; i < 3; i++)
		{
			additionalvertex.push_back(0);
		}
		if (maxAnglePos == 0)
		{
			//cout << "Add0" << endl;
			additionalvertex[0] = CircleElement[2] * cos(angle[2] + M_PI) + (double)CircleElement[0] ;
			additionalvertex[1] =CircleElement[2] * sin(angle[2] + M_PI) + (double)CircleElement[1];
		}
		else if (maxAnglePos == 1)
		{
			//cout << "Add1" << endl;
			additionalvertex[0] = CircleElement[2] * cos(angle[0] + M_PI) + (double)CircleElement[0];
			additionalvertex[1] = CircleElement[2] * sin(angle[0] + M_PI) + (double)CircleElement[1];
		}
		else if (maxAnglePos == 2)
		{
			//cout << "Add2" << endl;
			additionalvertex[0] = CircleElement[2] * cos(angle[1] + M_PI) + (double)CircleElement[0];
			additionalvertex[1] = CircleElement[2] * sin(angle[1] + M_PI) + (double)CircleElement[1];
		}
		findpoints.push_back(additionalvertex);
		//cout << "Add" << endl;
	
		//cout << maxAnglePos << endl;

		ofSetColor(0, 0, 255);
		ofFill();
		ofDrawCircle(ofPoint(-(double)additionalvertex[1] / rangeVal + ofGetWidth() / 2, (double)-additionalvertex[0] / rangeVal + (ofGetHeight()/2)), 5);


		return findpoints;
	}
	else
	{
		return findpoints;
	}
}
*/
/*
vector<vector<double>> URG_processsing::GetWagonTwoVertex(vector<vector<double>> findpoints, double width,double height)
{
	double angle =atan2(height,width);
	double radius = sqrt(pow(width,2)+pow(height,2))/2;
	vector<vector<double>> findFrames;
	for(int frameNum=0;frameNum<4;frameNum++)
	{
		if(findpoints[frameNum][2]>0)
		{
			vector<double> findFrame;
			findFrame.push_back(findpoints[frameNum][0]);
			findFrame.push_back(findpoints[frameNum][1]);
			findFrame.push_back(frameNum);
			findFrames.push_back(findFrame);
		}
	}

	if(findFrames.size()==2)
	{
		double center[2];
		double yaw;
		if(findFrames[0][2]==0 && findFrames[1][2]==1)
		{
			yaw=atan2(findFrames[0][1]-findFrames[1][1],findFrames[0][0]-findFrames[1][0]);
			double preCenter[2];
			preCenter[0]=0.5*(findFrames[0][0]+findFrames[1][0]);
			preCenter[1]=0.5*(findFrames[0][1]+findFrames[1][1]);
			center[0] = preCenter[0]+height/2.0*cos(yaw+M_PI/2.0*3.0);
			center[1] = preCenter[1]+height/2.0*sin(yaw+M_PI/2.0*3.0);
		}
		if(findFrames[0][2]==2 && findFrames[1][2]==3)
		{
			yaw=atan2(findFrames[0][1]-findFrames[1][1],findFrames[0][0]-findFrames[1][0])+M_PI;
			double preCenter[2];
			preCenter[0]=0.5*(findFrames[0][0]+findFrames[1][0]);
			preCenter[1]=0.5*(findFrames[0][1]+findFrames[1][1]);
			center[0] = preCenter[0]+height/2.0*cos(yaw+M_PI/2.0);
			center[1] = preCenter[1]+height/2.0*sin(yaw+M_PI/2.0);
		}
		else if(findFrames[0][2]==1 && findFrames[1][2]==2)
		{
			yaw=atan2(findFrames[1][1]-findFrames[0][1],findFrames[1][0]-findFrames[0][0])+M_PI/2.0;
			double preCenter[2];
			preCenter[0]=0.5*(findFrames[0][0]+findFrames[1][0]);
			preCenter[1]=0.5*(findFrames[0][1]+findFrames[1][1]);
			center[0] = preCenter[0]+width/2.0*cos(yaw);
			center[1] = preCenter[0]+width/2.0*sin(yaw);
		}
		else if(findFrames[0][2]==0 && findFrames[1][2]==3)
		{
			yaw=atan2(findFrames[0][1]-findFrames[1][1],findFrames[0][0]-findFrames[1][0])-M_PI/2.0;
			double preCenter[2];
			preCenter[0]=0.5*(findFrames[0][0]+findFrames[1][0]);
			preCenter[1]=0.5*(findFrames[0][1]+findFrames[1][1]);
			center[0] = preCenter[0]+width/2.0*cos(yaw+M_PI);
			center[1] = preCenter[1]+width/2.0*sin(yaw+M_PI);
		}
		else if(findFrames[0][2]==0 && findFrames[1][2]==2)
		{
			yaw=atan2(findFrames[0][1]-findFrames[1][1],findFrames[0][0]-findFrames[1][0])-angle;
			center[0]=0.5*(findFrames[0][0]+findFrames[1][0]);
			center[1]=0.5*(findFrames[0][1]+findFrames[1][1]);
		}
		else if(findFrames[0][2]==1 && findFrames[1][2]==3)
		{
			yaw=atan2(findFrames[0][1]-findFrames[1][1],findFrames[0][0]-findFrames[1][0])+angle;
			center[0]=0.5*(findFrames[0][0]+findFrames[1][0]);
			center[1]=0.5*(findFrames[0][1]+findFrames[1][1]);
		}

		findpoints.clear();
		vector<double>findpoint;
		findpoint.resize(2);

		findpoint[0] = center[0] + radius * cos(angle + yaw);
		findpoint[1] = center[1] + radius * sin(angle + yaw);
		findpoints.push_back(findpoint);
		findpoint[0] = center[0] + radius * cos(yaw + M_PI - angle);
		findpoint[1] = center[1] + radius * sin(yaw + M_PI - angle);
		findpoints.push_back(findpoint);
		findpoint[0] = center[0] + radius * cos(yaw + M_PI + angle);
		findpoint[1] = center[1] + radius * sin(yaw + M_PI + angle);
		findpoints.push_back(findpoint);
		findpoint[0] = center[0] + radius * cos(yaw + 2*M_PI - angle);
		findpoint[1] = center[1] + radius * sin(yaw + 2*M_PI - angle);

	}	
	return findpoints;

}
*/
double URG_processsing::GetWagonDirection(vector<vector<double>> findpoints, vector<double>CircleElement)
{
	double framelength[4];
	double angle[4],gangle[4];
	double sumangle[2] = {0,0};
	vector<int> framenumber;
	for (int i = 0; i < findpoints.size(); i++)
	{
		framenumber.push_back(i);
	}
	if (findpoints.size() == 4)
	{
		for (int i = 0; i < findpoints.size(); i++)
		{
			angle[i] = atan2(findpoints[i][1] - CircleElement[1], findpoints[i][0] - CircleElement[0]);
		}
		*gangle = *angle;
		sort(angle, angle + findpoints.size());
		for (int i = 0; i < findpoints.size(); i++)
		{
			for (int j = 0; j < findpoints.size(); j++)
			{
				if (gangle[i] == angle[j])
				{
					framenumber[i] = j;
				}
			}
		}
		sumangle[0] += angle[1] - angle[0];
		sumangle[0] += angle[3] - angle[2];
		sumangle[0] /= 2;

		sumangle[1] += angle[2] - angle[1];
		sumangle[1] += angle[0] + 2 * M_PI - angle[3];
		sumangle[1] /= 2;

		if (sumangle[0] > sumangle[1])
		{
			//cout << (angle[0]) / M_PI * 180 << endl;
			//cout << (sumangle[0]) / M_PI * 180 << endl;
			return sumangle[0] / 2 + angle[0];
		}
		else
		{
			//cout << (angle[0]) / M_PI * 180 << endl;
			//cout << (sumangle[0]) / M_PI * 180 << endl;
			return sumangle[1] / 2 + sumangle[0] + angle[0];
			//return angle[0];
		}
	}
	else
	{
		return 0;
	}
}
void URG_processsing::drawWagon(wagon wagonState, double Width, double Height)
{
	ofPoint vertex[4];

	double radius = sqrt(pow(Width, 2) + pow(Height, 2))/2;
	double angle = atan(Width / Height);

	vertex[0] = ofPoint(-wagonState.frame[0].y / rangeVal - (double)wagonState.pos.y / rangeVal + ofGetWidth() / 2, -wagonState.frame[0].x / rangeVal - (double)wagonState.pos.x / rangeVal + (ofGetHeight()/2)+ofGetHeight()/4);
	vertex[1] = ofPoint(-wagonState.frame[1].y / rangeVal - (double)wagonState.pos.y / rangeVal + ofGetWidth() / 2, -wagonState.frame[1].x / rangeVal - (double)wagonState.pos.x / rangeVal + (ofGetHeight()/2)+ofGetHeight()/4);
	vertex[2] = ofPoint(-wagonState.frame[2].y / rangeVal - (double)wagonState.pos.y / rangeVal + ofGetWidth() / 2, -wagonState.frame[2].x / rangeVal - (double)wagonState.pos.x / rangeVal + (ofGetHeight()/2)+ofGetHeight()/4);
	vertex[3] = ofPoint(-wagonState.frame[3].y / rangeVal - (double)wagonState.pos.y / rangeVal + ofGetWidth() / 2, -wagonState.frame[3].x / rangeVal - (double)wagonState.pos.x / rangeVal + (ofGetHeight()/2)+ofGetHeight()/4);

	ofSetColor(255, 0, 0);

	ofSetLineWidth(4);
	ofCircle(ofPoint((double)-wagonState.pos.y / rangeVal + ofGetWidth() / 2, (double)-wagonState.pos.x / rangeVal + (ofGetHeight()/2)+ofGetHeight()/4), 2);

	
	ofDrawLine(ofPoint(-50 * sin(wagonState.pos.z) - (double)wagonState.pos.y / rangeVal + ofGetWidth() / 2, -50 * cos(wagonState.pos.z)  -(double)wagonState.pos.x / rangeVal + (ofGetHeight()/2)+ofGetHeight()/4), ofPoint(-(double)wagonState.pos.y / rangeVal + ofGetWidth() / 2, (double)-wagonState.pos.x / rangeVal + (ofGetHeight()/2)+ofGetHeight()/4));

	ofDrawLine(vertex[0], vertex[1]);	
	ofDrawLine(vertex[1], vertex[2]);
	ofDrawLine(vertex[2], vertex[3]);
	ofDrawLine(vertex[3], vertex[0]);
	
}
void URG_processsing::drawWagonR(wagon wagonState, double Width, double Height)
{
	ofPoint vertex[4];

	double radius = sqrt(pow(Width, 2) + pow(Height, 2))/2;
	double angle = atan(Width / Height);

	vertex[0] = ofPoint(-wagonState.frame[0].y / rangeVal - (double)wagonState.pos.y / rangeVal + ofGetWidth() / 2, -wagonState.frame[0].x / rangeVal - (double)wagonState.pos.x / rangeVal + (ofGetHeight()/2)+ofGetHeight()/4);
	vertex[1] = ofPoint(-wagonState.frame[1].y / rangeVal - (double)wagonState.pos.y / rangeVal + ofGetWidth() / 2, -wagonState.frame[1].x / rangeVal - (double)wagonState.pos.x / rangeVal + (ofGetHeight()/2)+ofGetHeight()/4);
	vertex[2] = ofPoint(-wagonState.frame[2].y / rangeVal - (double)wagonState.pos.y / rangeVal + ofGetWidth() / 2, -wagonState.frame[2].x / rangeVal - (double)wagonState.pos.x / rangeVal + (ofGetHeight()/2)+ofGetHeight()/4);
	vertex[3] = ofPoint(-wagonState.frame[3].y / rangeVal - (double)wagonState.pos.y / rangeVal + ofGetWidth() / 2, -wagonState.frame[3].x / rangeVal - (double)wagonState.pos.x / rangeVal + (ofGetHeight()/2)+ofGetHeight()/4);

	ofSetColor(0, 255, 0);

	ofSetLineWidth(4);
	ofCircle(ofPoint((double)-wagonState.pos.y / rangeVal + ofGetWidth() / 2, (double)-wagonState.pos.x / rangeVal + (ofGetHeight()/2)), 2);

	
	ofDrawLine(ofPoint(-50 * sin(wagonState.pos.z) - (double)wagonState.pos.y / rangeVal + ofGetWidth() / 2, -50 * cos(wagonState.pos.z)  -(double)wagonState.pos.x / rangeVal + (ofGetHeight()/2)+ofGetHeight()/4), ofPoint(-(double)wagonState.pos.y / rangeVal + ofGetWidth() / 2, (double)-wagonState.pos.x / rangeVal + (ofGetHeight()/2)+ofGetHeight()/4));

	ofDrawLine(vertex[0], vertex[1]);	
	ofDrawLine(vertex[1], vertex[2]);
	ofDrawLine(vertex[2], vertex[3]);
	ofDrawLine(vertex[3], vertex[0]);
	
}
void URG_processsing::drawWagonP(wagon wagonState, double radius,double Width, double Height)
{
	ofPoint vertex[4];

	double angle = atan(Width / Height);

	vertex[0] = ofPoint(-wagonState.frame[0].y / rangeVal - (double)wagonState.pos.y / rangeVal + ofGetWidth() / 2, -wagonState.frame[0].x / rangeVal - (double)wagonState.pos.x / rangeVal + (ofGetHeight()/2)+ofGetHeight()/4);
	vertex[1] = ofPoint(-wagonState.frame[1].y / rangeVal - (double)wagonState.pos.y / rangeVal + ofGetWidth() / 2, -wagonState.frame[1].x / rangeVal - (double)wagonState.pos.x / rangeVal + (ofGetHeight()/2)+ofGetHeight()/4);
	vertex[2] = ofPoint(-wagonState.frame[2].y / rangeVal - (double)wagonState.pos.y / rangeVal + ofGetWidth() / 2, -wagonState.frame[2].x / rangeVal - (double)wagonState.pos.x / rangeVal + (ofGetHeight()/2)+ofGetHeight()/4);
	vertex[3] = ofPoint(-wagonState.frame[3].y / rangeVal - (double)wagonState.pos.y / rangeVal + ofGetWidth() / 2, -wagonState.frame[3].x / rangeVal - (double)wagonState.pos.x / rangeVal + (ofGetHeight()/2)+ofGetHeight()/4);

	ofSetLineWidth(4);
	for (int i = 0; i < 4; i++)
	{
		ofSetColor(0, 0, 0);
		ofNoFill();
		ofCircle(vertex[i], radius / rangeVal);
	}
	ofSetColor(0, 0, 255);

	ofCircle(ofPoint((double)-wagonState.pos.y / rangeVal + ofGetWidth() / 2, (double)-wagonState.pos.x / rangeVal + (ofGetHeight()/2)+ofGetHeight()/4), 2);

	
	ofDrawLine(ofPoint(-50 * sin(wagonState.pos.z) - (double)wagonState.pos.y / rangeVal + ofGetWidth() / 2, -50 * cos(wagonState.pos.z)  -(double)wagonState.pos.x / rangeVal + (ofGetHeight()/2)+ofGetHeight()/4), ofPoint(-(double)wagonState.pos.y / rangeVal + ofGetWidth() / 2, (double)-wagonState.pos.x / rangeVal + (ofGetHeight()/2)+ofGetHeight()/4));
	ofDrawLine(vertex[0], vertex[1]);	
	ofDrawLine(vertex[1], vertex[2]);
	ofDrawLine(vertex[2], vertex[3]);
	ofDrawLine(vertex[3], vertex[0]);
}