#pragma once

#include <iostream>
#include<fstream>
#include<iostream>
#include<string>
#include<sstream> 
#include <vector>
#include <Eigen/Dense>
#include "robot.h"
#include "wagon.h"
using namespace Eigen;
using namespace std;


class kalmanfilter
{
private:
	MatrixXd I;//=cv::Mat_<double>(2,2);
	//=cv::Mat_<double>(2,2);
	MatrixXd y1;//=cv::Mat_<double>(2,1);
	MatrixXd yb;//=cv::Mat_<double>(2,1);
	MatrixXd xb;//=cv::Mat_<double>(1,2);
	MatrixXd p1;//=cv::Mat_<double>(2,2);
	
	MatrixXd g;//=cv::Mat_<double>(1,2);
	MatrixXd A;//=cv::Mat_<double>(2,2);
	MatrixXd b;//=cv::Mat_<double>(1,2);
	MatrixXd c;//=cv::Mat_<double>(2,1);
	MatrixXd cd;//=cv::Mat_<double>(2,1);
	MatrixXd R;
	MatrixXd Q;
	MatrixXd RobotMat;

	double sigmaV, sigmaW;
	double time = 0;
	wagon before;
public:

	MatrixXd pb;//=cv::Mat_<double>(2,2);
	MatrixXd xO;
	MatrixXd x1;
	MatrixXd x2;
	kalmanfilter();
	~kalmanfilter();

	wagon initialize(wagon observe,robot Robot,double nowtime);
	wagon globalInitialize(wagon observe,vector<double> pose, robot Robot, double nowtime);
	wagon predictStep(wagon observe, double nowtime,robot Robot,bool checkGrasp );
	wagon getNotFilteringOutput(wagon predict,wagon observe,robot Robot);
	wagon filteringStep(wagon predict,wagon observe,robot Robot);
	wagon filteringStep(robot Robot);
};