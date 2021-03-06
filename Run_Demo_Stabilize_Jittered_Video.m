%-------------------------------------
% This is the demo file for running the Online Thinning algorithm with a
% parking lot surveillance video with artificial jitters
% This demo first generate a jittered video, perform Online Thinning on the
% jittered video, then perform video stabilization on the thinned video
% 
% 
% Created by Xin Jiang (chlorisjiang@gmail.com)
% June 06, 2016
%-------------------------------------
clc; clear; close all;

% Add code directory and VL_FEAT toolbox
addpath Functions/ % Online Thinning functions
addpath demo_videos/ % input video file
addpath vl_feat_0.9.19/toolbox % VL_FEAT toolbox
run vl_setup; % setup VL_FEAT


% The Online Thinning algorithm uses the first frame for training, and
% process the video frame-by-frame. On each frame, the SIFT features are
% computed on a grid placed 33 x 33 pixels apart (can be changed by setting
% up the parameters for SIFT in Online_Thinning_Video), and the algorithm
% processes all SIFT features from the same frame in a mini-batch. An
% anomalouseness score is assigned by the Online Thinning algorithm for
% each SIFT feature vector (which corresponds to a small patch in the 
% image). After the computation of the scores, we flag the top 5% of
% patches with the highest and use only the flagged patches and a reference
% frame (reset every 30 frames) to stabilize the flagged patches. 
% The stabilization method is explained in 
% http://www.mathworks.com/help/vision/examples/video-stabilization-using-point-feature-matching.html

% Due to the small number of pixels in the thinned frames (only top 5% of 
% patches), the stabilization method occasionally fails to find enough
% matching points, which results in sudden shift and warping of images. 
% This can be alleviated by increasing the number of patches in the flagged 
% video or including some surrounding pixels around each flagged patch in
% the stabilization.

% The shifting of stabilizaed video every few seconds is a result of the 
% reference frame reset. 
% Since the camera is constantly moving, resetting the reference frame 
% allows the scope of the stabilized video to follow the actual scene.

% The output video will be stored in 'output_stabilize_demo.avi'. Note that because
% the first frame is used for initialization, the actual output video will
% be one frame shorter than the input video.

inVideoName = 'original_demo.avi';
jitteredVideoName = 'demo_videos/jittered_demo.avi';
outVideoName = 'demo_videos/output_stabilize_demo.avi';
% first add jitter to the original video
JitterVideo(inVideoName,jitteredVideoName);
% then perform Online Thinning and stabilize the video using flagged
% patches
Online_Thinning_Jittered_Video(jitteredVideoName,outVideoName);
