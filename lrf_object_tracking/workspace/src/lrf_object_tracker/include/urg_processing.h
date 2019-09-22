#pragma once
#undef Success 
#include "ofMain.h"

#include <iostream>
#include<fstream>
#include<iostream>
#include<string>
#include<sstream> 
#include "Eigen/Dense"
#include "wagon.h"
#include "URG.h"
using namespace std;
class URG_processsing {
	vector<long> dataFromURG1;
	URG URG1;
	double drawRange;
	double rangeVal;
	vector<vector<double>> foundPoints;
	vector<vector<double>> extractedPoints;

public:

	URG_processsing();
	void setURG1(URG urg);
	void setDataFromURG1(vector<long>data);
	void setDrawRange(double DrawRange);
	void drawData();

	void findPoints(int length, double minWidth,double maxWidth, vector<double> SearchRange);
	void drawFoundPoints(bool extracted);

	void extractPoints(wagon wagonState, double radius);
	vector<vector<double>> getExtractedPoints();

	int getCandidateNum(wagon wagonState,double radius);

	double GetWagonDirection(vector<vector<double>> findpoints, vector<double>CircleElement);
	wagon getWagonPose(wagon observedWagon);
	
	//vector<vector<double>> GetWagonVertex(vector<vector<double>> findpoints, vector<double>CircleElement,double range);
	//vector<vector<double>> GetWagonTwoVertex(vector<vector<double>> findpoints, double width,double height);

	void drawWagon(wagon wagonState, double Width, double Height);
	void drawWagonR(wagon wagonState, double Width, double Height);
	void drawWagonP(wagon wagonState, double radius,double Width, double Height);
};

class candidate{

	public:
		double x;
		double y;
		double radius;
		double distance[4];
};