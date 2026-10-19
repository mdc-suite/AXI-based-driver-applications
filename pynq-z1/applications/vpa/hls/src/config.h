#ifndef HOUGH_CONFIG_H
#define HOUGH_CONFIG_H

// Sensing
#define IMG_WIDTH           	(88) // Pixels
#define IMG_HEIGHT          	(142) // Pixels
#define H_I_W					(44) //IMG_WIDTH/2
#define H_I_H 					(71) //IMG_HEIGHT/2
#define IMG_SIZE            	(12496) // Pixels
#define DESIRED_POS         	(0.02) // Pixels
#define PIXEL_RATIO         	(0.001) // 1 milimeter (1 pixel = 0.001 milimeter)

// Controller
#define SAMPLING_TIME       	((float)0.001) //il sistema di muove di un pixel alla volta
#define INV_SAMPLING_TIME   	((float)1000)
#define K_P                 	((float)1500) //coefficienti del controller PID (proporzionale)
#define K_I                 	((float)500)  //(integrale)
#define K_D                 	((float)200)  //(derivativo)
#define PI                  	(3.1416)

// KALMAN MODE
#define MODE_IDLE               (0)
#define MODE_1              	(1)
#define MODE_2              	(2)
#define MODE_3              	(3)
#define MODE_4              	(4)

// MONITORING MODE
#define STATE_INIT          	(1)  // INIT STATE
#define STATE_A 				(2)  // STATE_1_RUN_2_STOP INIT
#define STATE_B      			(3)  // STATE_1_RUN_2_SEND
#define STATE_C     			(4)  // STATE_1_RUN_2_RUN After send to tile 2
#define STATE_D   				(5)  // STATE_1_RECEIVE_2_RUN
#define STATE_E      			(6)  // STATE_1_STOP_2_RUN
#define STATE_F      			(7)  // STATE_1_SEND_2_RUN
#define STATE_G     			(8)  // STATE_1_RUN_2_RUN_B After send to tile 1
#define STATE_H   				(9)  // STATE_1_RUN_2_RECEIVE
#define STATE_I      			(10) // STATE_1_RUN_2_STOP After Init
#define NUMBER_OF_STATE_A		(14)
#define NUMBER_OF_STATE_C		(12)
#define NUMBER_OF_STATE_E		(1)
#define NUMBER_OF_STATE_G		(12)
#define NUMBER_OF_STATE_I		(1)

// Sensing
// #define THETA_neg_5_pos_5
// #define THETA_neg_4_pos_4
#define THETA_neg_3_pos_3
#define HOUGH_THRESHOLD     	(8)
#define PADDING_SIZE_THETA  	(3) // Pixels
#define PADDING_SIZE_RHO    	(3) // Pixels
#define MAX_PEAK_NUMBER     	(2) // il picco viene identificato tramite cordinate (2 numeri)
// #define THETA_0_pos_5
// #define THETA_0_pos_30

#if defined(THETA_neg_5_pos_5)
#define NUMBER_OF_THETA     	(11)
#define THETA_MIN           	(-5)
#define THETA_MAX           	(5)
#define MAX_NEGATIVE_RHO    	(13)    // IMG_HEIGHT*sind(THETA_MIN)
#define NUMBER_OF_RHO       	(113)   // (IMG_WIDTH*cosd(THETA_MAX) + IMG_HEIGHT*sind(THETA_MAX) + MAX_NEGATIVE_RHO)
#define HOUGH_AREA_SIZE     	(NUMBER_OF_THETA * NUMBER_OF_RHO)  // NUMBER_OF_RHO * NUMBER_OF_THETA
#define DISTANCE_BETWEEN_CHIPS  (7)
#define THETA_START_TILE_1      (-5)
#define THETA_END_TILE_1        (5)
#define THETA_START_TILE_2      (-5)
#define THETA_END_TILE_2        (5)

#elif defined(THETA_neg_4_pos_4)
#define NUMBER_OF_THETA     	(9)
#define THETA_MIN           	(-4)
#define THETA_MAX           	(4)
#define MAX_NEGATIVE_RHO    	(10)    // IMG_HEIGHT*sind(THETA_MIN)
#define NUMBER_OF_RHO       	(108)   // (IMG_WIDTH*cosd(THETA_MAX) + IMG_HEIGHT*sind(THETA_MAX) + MAX_NEGATIVE_RHO)
#define HOUGH_AREA_SIZE     	(NUMBER_OF_THETA * NUMBER_OF_RHO)  // NUMBER_OF_RHO * NUMBER_OF_THETA
#define DISTANCE_BETWEEN_CHIPS  (7)
#define THETA_START_TILE_1      (-4)
#define THETA_END_TILE_1        (0)
#define THETA_START_TILE_2      (1)
#define THETA_END_TILE_2        (4)

#elif defined(THETA_neg_3_pos_3)
#define NUMBER_OF_THETA     	(7)
#define THETA_MIN           	(-3)    //Theta và da -3 a 3 gradi
#define THETA_MAX           	(3)
//Dobbiamo definire lo spazio rho del piano di Hough e per farlo partiamo dal calcolo di quanti valori di rho
//possono avere valori inferiori a 0! questo è importante perchè useremo questo valore come offset per normalizzare
//lo spazio di calcolo facendolo partire da 0.
//Il valore negativo massimo si ha con il seno dell'angolo minore (THETA_MIN = -3) applicato nel punto con x minima e y massima (x = 0, y = IMG_HEIGHT):
//#define MAX_NEGATIVE_RHO    	(14)     // 256x256 IMG_HEIGHT*sind(THETA_MIN) + 0*cos(THETA_MIN)
#define MAX_NEGATIVE_RHO    	(8)     // 142x88 IMG_HEIGHT*sind(THETA_MIN) + 0*cos(THETA_MIN)
//Per calcolare il numero massimo  di Rho possibili utiliziamo un metodo additivo:
//Sappiamo dalla formula che rho=x*cos(theta)+y*sin(theta) e questo rappresenta la distanza trà l'origine degli assi e la retta
//passante per il punto(punto qualsiasi dell'immagine e retta con un certa angolazione theta)
//a questo punto possiamo dire che rho_max è quello del punto più lontano (in alto a sinistra ---> x = IMG_WIDTH, y = IMG_HEIGHT)
//e con l'angolo maggiore(THETA_MAX=3)
//rho_max = IMG_WIDTH*cos(THETA_MAX) + IMG_HEIGHT*sin(THETA_MAX)
//ora a queso valore ci manca solo da aggiungere il numero totale di rho negativi (MAX_NEGATIVE_RHO=8):
//#define NUMBER_OF_RHO       	(276)   //256x256 (IMG_WIDTH*cosd(THETA_MAX) + IMG_HEIGHT*sind(THETA_MAX) + MAX_NEGATIVE_RHO)
//#define HOUGH_AREA_SIZE     	(3864)  //256x256 NUMBER_OF_RHO * NUMBER_OF_THETA
#define NUMBER_OF_RHO       	(104)   //142x88 (IMG_WIDTH*cosd(THETA_MAX) + IMG_HEIGHT*sind(THETA_MAX) + MAX_NEGATIVE_RHO)
#define HOUGH_AREA_SIZE     	(728)  //142x88 NUMBER_OF_RHO * NUMBER_OF_THETA
#define DISTANCE_BETWEEN_CHIPS  (7)
#define THETA_START_TILE_1      (-3)
#define THETA_END_TILE_1        (3)
#define THETA_START_TILE_2      (-3)
#define THETA_END_TILE_2        (3)

#endif

// Kalman Filter
#define BIAS_THRESHOLD      (1.7525E-06) // With error
// #define BIAS_THRESHOLD      (0.004) // Without error
#define R_DEFAULT           (2.5000e-17)
#define R_BIAS              (1.2250e-11)

#endif //HOUGH_CONFIG_H
